# Index Performance auf JSONB oder Arrays — PostgreSQL

## 1. What it is

Without an index, any query filtering into a JSONB document or array column does a **sequential scan**: Postgres reads every row and checks the condition row by row. For small tables this is fine; at scale it isn't. Both JSONB and arrays support **GIN indexes** (Generalized Inverted Index) — an index structure built for "does this container hold X" style lookups, as opposed to the B-tree indexes used for plain scalar columns.

The core idea of GIN: instead of indexing the whole document/array as one value, it indexes the individual _elements_ (array items, or JSONB keys and values) and points back to the rows containing them. That's what makes containment queries fast.

---

## 2. GIN indexes on JSONB

**Default GIN index:**

```sql
CREATE INDEX idx_attrs ON products USING GIN (attributes);
```

Supports: `@>`, `?`, `?|`, `?&`. Indexes every key and value in the document, so it's flexible but larger.

**`jsonb_path_ops` variant:**

```sql
CREATE INDEX idx_attrs_ops ON products USING GIN (attributes jsonb_path_ops);
```

Supports **only** `@>` — but the index is roughly half the size, faster to build, and faster to query. This is the better default if containment is your dominant query pattern and you don't need `?`/`?|`/`?&`.

**Expression (B-tree) index — for a single, always-queried key:**

```sql
CREATE INDEX idx_brand ON products ((attributes->>'brand'));
```

A normal B-tree on a computed value. Supports `=`, `<`, `>`, `ORDER BY` — things GIN can't do well. If you keep creating these for the same key, that's usually a sign the key deserves to be a real column instead.

---

## 3. GIN indexes on arrays

```sql
CREATE INDEX idx_labels ON articles USING GIN (labels);
```

Supports: `@>`, `<@`, `&&` (contains, contained by, overlap).

Notes:

- `= ANY(arr)` on a single value is **not** accelerated by GIN the same way — GIN is built for containment/overlap, not single-element equality lookups. For "does array contain exactly this one value" at scale, `@>` with a single-element array (`labels @> ARRAY['sql']`) is the index-friendly equivalent of `= ANY()`.
- If you need heavy relational querying on individual elements (joins, aggregations, uniqueness per element), a proper join table will usually outperform an array + GIN index — GIN is great for filtering, not for relational operations.

---

## 4. Verifying an index is actually used

```sql
EXPLAIN ANALYZE
SELECT * FROM products WHERE attributes @> '{"brand": "Dell"}';
```

Look at the plan:

- `Bitmap Index Scan` / `Index Scan` on your index name → the index is being used.
- `Seq Scan` → either the planner decided the table is too small to bother (very common — Postgres genuinely may be right on tiny tables), or your query isn't using an indexable operator (e.g. `->>'brand' = 'Dell'` without an expression index won't use a plain GIN index).

Rule of thumb for testing: don't trust `EXPLAIN` results on a handful of test rows — seed the table with realistic volume before judging whether an index actually helps.

---

## 5. Write cost — the tradeoff side

GIN indexes are **more expensive to write to** than B-tree indexes, and larger on disk. Every insert/update that touches an indexed JSONB or array column has to update the index too.

Practical implications:

- Don't blindly GIN-index a JSONB/array column that's updated very frequently unless the read pattern genuinely needs it.
- `fastupdate` (a GIN storage parameter) batches index updates via a pending list to reduce write amplification — on by default, usually fine to leave alone unless you're doing heavy bulk-write tuning.
- For write-heavy tables, consider whether the queried field should be pulled out into a real, B-tree-indexed column instead of relying on GIN over the whole blob.

---

## 6. Choosing the right index — decision guide

|Situation|Best choice|
|---|---|
|Query with `@>` on JSONB, need `?`/`?|`/`?&` too|
|Query with `@>` on JSONB only|GIN with `jsonb_path_ops`|
|Always filter/sort on one specific JSONB key|Expression (B-tree) index on `data->>'key'`|
|Array containment/overlap (`@>`, `<@`, `&&`)|GIN on the array column|
|Single-value array membership at scale|`@>` with single-element array + GIN (not `= ANY()`)|
|Frequent updates to the indexed column, low query volume|Consider skipping the index or pulling the field out into a plain column|
|Heavy relational queries on individual array elements|Normalize into a join table instead of using an array|

---

## 7. Quick mental model

|Stage|JSONB|Array|
|---|---|---|
|No index|Seq scan, parse per row|Seq scan, check per row|
|GIN index|Index on keys/values → row fetch|Index on elements → row fetch|
|Best "single key" case|Expression B-tree index|N/A (arrays are flat, no sub-keys)|
|Write cost|Higher (GIN update per write)|Higher (GIN update per write)|

**Bottom line:** GIN indexing is what makes both JSONB and array containment queries fast, but it's not free — it costs write throughput and disk space. Use `EXPLAIN ANALYZE` to confirm the index is actually being picked, and lean on expression indexes or plain columns once you notice a specific key or value getting queried constantly.