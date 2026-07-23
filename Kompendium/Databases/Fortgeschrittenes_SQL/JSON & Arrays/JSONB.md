# JSONB Operatoren & Funktionen — PostgreSQL

## 1. What it is

JSONB ("JSON Binary") is a PostgreSQL data type for storing JSON documents in a parsed, binary tree format instead of raw text. It's parsed and validated at write time (not read time), doesn't preserve key order, and supports indexing — unlike the plain `JSON` type.

---

## 2. Setup and basic lifecycle

```sql
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  attributes JSONB
);
```

**Insert:**

```sql
INSERT INTO products (name, attributes) VALUES
('Laptop', '{"brand": "Dell", "ram_gb": 16, "tags": ["electronics", "computers"]}'),
('Mouse',  '{"brand": "Logitech", "wireless": true}');
```

Or build it from SQL values instead of raw text:

```sql
INSERT INTO products (name, attributes)
VALUES ('Keyboard', jsonb_build_object('brand', 'Corsair', 'keys', 104));
```

**Read:**

```sql
SELECT attributes->>'brand' FROM products WHERE name = 'Laptop';
```

**Update:**

```sql
UPDATE products
SET attributes = jsonb_set(attributes, '{ram_gb}', '32')
WHERE name = 'Laptop';
```

⚠️ Even a targeted `jsonb_set` call still causes Postgres to rewrite the _entire row_ on disk — this is just how Postgres MVCC works, not JSONB-specific, but it matters for high-frequency partial updates on large documents.

---

## 3. Operator cheat sheet

|Operator|Name|Returns|Example|What it does|
|---|---|---|---|---|
|`->`|field access|jsonb|`attrs->'brand'`|Get object field or array element **as JSONB**|
|`->>`|field access (text)|text|`attrs->>'brand'`|Get object field or array element **as text**|
|`#>`|path access|jsonb|`attrs#>'{a,b}'`|Get value at a JSON path **as JSONB**|
|`#>>`|path access (text)|text|`attrs#>>'{a,b}'`|Get value at a JSON path **as text**|
|`@>`|contains|boolean|`attrs @> '{"wireless":true}'`|Does the left JSONB contain the right JSONB? (index-friendly)|
|`<@`|contained by|boolean|`'{"a":1}' <@ attrs`|Reverse of `@>`|
|`?`|key/element exists|boolean|`attrs ? 'tags'`|Does this top-level key (or array element) exist?|
|`?\|`|any key exists|boolean|`attrs ?\| array['a','b']`|Does **any** of these keys exist?|
|`?&`|all keys exist|boolean|`attrs ?& array['a','b']`|Do **all** of these keys exist?|
|`\|`|concatenate|jsonb|`attrs \| '{"new":1}'`|Merge two JSONB objects (right side wins on key conflict)|
|`-`|delete key|jsonb|`attrs - 'wireless'`|Remove a top-level key or array element|
|`#-`|delete at path|jsonb|`attrs #- '{a,b}'`|Remove a nested value at a path|
|`@?`|path exists (jsonpath)|boolean|`attrs @? '$.ram_gb ? (@ > 8)'`|Does a jsonpath expression match anything?|
|`@@`|path predicate check|boolean|`attrs @@ '$.ram_gb > 8'`|Evaluate a jsonpath predicate directly|

**`->` vs `->>` in one line:** `->` keeps it as JSONB (chainable, keeps quotes on strings); `->>` converts to plain text (use this when comparing to a regular string in `WHERE`).

---

## 4. Function cheat sheet

|Function|What it does|Example|
|---|---|---|
|`jsonb_set(target, path, new_value, create_missing)`|Update/insert a value at a path|`jsonb_set(attrs, '{ram_gb}', '32')`|
|`jsonb_insert(target, path, new_value)`|Insert without overwriting existing value|`jsonb_insert(attrs, '{tags,0}', '"new"')`|
|`jsonb_build_object(k1, v1, ...)`|Build a JSONB object from SQL values|`jsonb_build_object('brand','Dell')`|
|`jsonb_build_array(v1, v2, ...)`|Build a JSONB array from SQL values|`jsonb_build_array(1,2,3)`|
|`jsonb_each(data)`|Expand top-level key/value pairs into rows (value as jsonb)|used with `LATERAL` / `FROM`|
|`jsonb_each_text(data)`|Same, but value as text|—|
|`jsonb_array_elements(data)`|Expand a JSONB array into rows (as jsonb)|`jsonb_array_elements(attrs->'tags')`|
|`jsonb_array_elements_text(data)`|Same, but as text|—|
|`jsonb_object_keys(data)`|Get all top-level keys as rows|`SELECT jsonb_object_keys(attrs)`|
|`jsonb_array_length(data)`|Count elements in a JSONB array|`jsonb_array_length(attrs->'tags')`|
|`jsonb_typeof(data)`|Returns the JSON type of a value (`object`, `array`, `string`, `number`, `boolean`, `null`)|`jsonb_typeof(attrs->'ram_gb')`|
|`jsonb_strip_nulls(data)`|Removes keys whose value is JSON null|—|
|`jsonb_path_query(data, path)`|Query using SQL/JSON path language (powerful filtering/wildcards)|`jsonb_path_query(attrs, '$.tags[*]')`|
|`to_jsonb(value)`|Convert any SQL value/row to JSONB|`to_jsonb(now())`|

---

## 5. Functional / real-world examples

**Filter rows where a nested condition matches:**

```sql
SELECT * FROM products WHERE attributes @> '{"wireless": true}';
```

**Filter using a specific key as text:**

```sql
SELECT * FROM products WHERE attributes->>'brand' = 'Dell';
```

**Unnest a tags array into rows (e.g. for a tag-count report):**

```sql
SELECT name, tag
FROM products, jsonb_array_elements_text(attributes->'tags') AS tag;
```

**Merge in a new field without touching the rest:**

```sql
UPDATE products
SET attributes = attributes || '{"on_sale": true}'
WHERE name = 'Mouse';
```

**Remove a field:**

```sql
UPDATE products
SET attributes = attributes - 'wireless'
WHERE name = 'Mouse';
```

**Conditional query with jsonpath (e.g. "RAM greater than 8GB"):**

```sql
SELECT * FROM products WHERE attributes @? '$.ram_gb ? (@ > 8)';
```

**Aggregate rows back into a JSONB array:**

```sql
SELECT jsonb_agg(attributes) FROM products;
```