# Native Arrays in SQL (text array) — PostgreSQL

## 1. What it is

PostgreSQL lets you declare a column as an **array of a given type** directly — no separate junction table needed for simple lists. `TEXT[]` is the most common case: a column holding a variable-length list of strings.

Arrays are a good fit when the data is a **flat, homogeneous list** (tags, categories, aliases). They're not a general substitute for relational modeling — if the list items need their own attributes or relationships, use a join table instead.

**Available since:** arrays are a core Postgres feature, not an extension — they've been there since early versions.

---

## 2. Setup and basic lifecycle

```sql
CREATE TABLE articles (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  labels TEXT[]
);
```

**Insert** — two equivalent syntaxes:

```sql
-- Postgres array literal syntax
INSERT INTO articles (title, labels) VALUES
('Intro to SQL', '{"database","tutorial","beginner"}');

-- ARRAY constructor syntax (often clearer, avoids quoting headaches)
INSERT INTO articles (title, labels) VALUES
('Advanced Joins', ARRAY['database', 'sql', 'advanced']);
```

**Read:**

```sql
SELECT labels FROM articles WHERE title = 'Intro to SQL';
-- {database,tutorial,beginner}

SELECT labels[1] FROM articles WHERE title = 'Intro to SQL';
-- 'database'  (Postgres arrays are 1-indexed by default)
```

**Update:**

```sql
-- Append an element
UPDATE articles SET labels = array_append(labels, 'sql') WHERE title = 'Intro to SQL';

-- Remove an element by value
UPDATE articles SET labels = array_remove(labels, 'beginner') WHERE title = 'Intro to SQL';

-- Replace the whole array
UPDATE articles SET labels = ARRAY['database', 'sql'] WHERE title = 'Intro to SQL';
```

---

## 3. Operator cheat sheet

|Operator|Name|Returns|Example|What it does|
|---|---|---|---|---|
|`[]`|subscript|element|`labels[1]`|Get element at position (1-indexed)|
|`[a:b]`|slice|array|`labels[1:2]`|Get a sub-array from position a to b|
|`= ANY()`|membership|boolean|`'sql' = ANY(labels)`|Does the array contain this exact value?|
|`= ALL()`|universal|boolean|`x = ALL(labels)`|Do **all** elements equal x? (rare, mostly for comparisons)|
|`@>`|contains|boolean|`labels @> '{"sql"}'`|Does the left array contain all elements of the right array?|
|`<@`|contained by|boolean|`'{"sql"}' <@ labels`|Reverse of `@>`|
|`&&`|overlap|boolean|`labels && '{"sql","nosql"}'`|Do the two arrays share **any** element?|
|`\|`|concatenate|array|`labels \| ARRAY['new']`|Join two arrays (or append a single element)|
|`=`|equality|boolean|`labels = ARRAY['a','b']`|Exact match, same order and length|

**`@>`/`<@`/`&&` are the ones that benefit from GIN indexing** — same operators you'd use on JSONB, which makes sense since arrays and JSONB share indexing infrastructure under the hood.

---

## 4. Function cheat sheet

|Function|What it does|Example|
|---|---|---|
|`array_length(arr, dim)`|Number of elements along a dimension (usually `1`)|`array_length(labels, 1)`|
|`array_append(arr, elem)`|Add an element to the end|`array_append(labels, 'new')`|
|`array_prepend(elem, arr)`|Add an element to the start|`array_prepend('new', labels)`|
|`array_remove(arr, elem)`|Remove all occurrences of a value|`array_remove(labels, 'old')`|
|`array_replace(arr, from, to)`|Replace all occurrences of a value|`array_replace(labels, 'old', 'new')`|
|`array_position(arr, elem)`|Index of the first occurrence of a value|`array_position(labels, 'sql')`|
|`array_to_string(arr, sep)`|Join array elements into a single string|`array_to_string(labels, ', ')`|
|`string_to_array(str, sep)`|Split a string into an array|`string_to_array('a,b,c', ',')`|
|`unnest(arr)`|Expand an array into rows (the big one — used constantly)|`unnest(labels)`|
|`array_agg(col)`|The reverse of `unnest`: aggregate rows into an array|`array_agg(label)`|
|`cardinality(arr)`|Total number of elements (works across multiple dimensions too)|`cardinality(labels)`|

---

## 5. Functional / real-world examples

**Find rows containing a specific tag:**

```sql
SELECT * FROM articles WHERE 'sql' = ANY(labels);
```

**Find rows whose tags overlap with a given set:**

```sql
SELECT * FROM articles WHERE labels && ARRAY['sql', 'nosql'];
```

**Find rows that contain _all_ of a given set of tags:**

```sql
SELECT * FROM articles WHERE labels @> ARRAY['sql', 'database'];
```

**Expand tags into rows** (e.g. to count tag frequency):

```sql
SELECT unnest(labels) AS label, COUNT(*)
FROM articles
GROUP BY label
ORDER BY COUNT(*) DESC;
```

**Aggregate rows back into an array** (reverse direction — e.g. group all titles per label):

```sql
SELECT label, array_agg(title) AS titles
FROM articles, unnest(labels) AS label
GROUP BY label;
```

**Append a tag conditionally:**

```sql
UPDATE articles
SET labels = array_append(labels, 'reviewed')
WHERE title = 'Intro to SQL' AND NOT ('reviewed' = ANY(labels));
```

---

## 6. Arrays vs JSONB — quick comparison

||`TEXT[]` (array)|`JSONB`|
|---|---|---|
|Best for|Flat, homogeneous lists|Nested / mixed-type structured data|
|Storage overhead|Lower|Higher (per-key overhead)|
|Indexing|GIN via `@>`, `<@`, `&&`|GIN via `@>`, `?`, `?\|`, `?&`|
|Structure|No nesting, single type per column|Arbitrary nesting, mixed types|
|Typical use|Tags, categories, simple ID lists|Settings, variable attributes, API payloads|

Rule of thumb: if every element in the list is "the same kind of thing" and flat, use an array. If you need structure inside each item, JSONB (or a proper child table) is the better fit.