SET search_path TO music_store;

-- EXPLAIN is used to fetch information about the given query. It allows multiple parameters
--      Analyze: Runs the depicted query instead of tracking information
--      Verbose: Includes any related information
--      Format: Changes the output format, such as JSON, XML, YAML
--      ...

-- ANALYZE is not to be confused with EXPLAIN ANALYZE

EXPLAIN
SELECT
    a.album_title,
    g.genre_name,
    COUNT(p.purchase_id) AS total_purchases
FROM
    albums a
JOIN
    genres g ON a.genre_id = g.genre_id
JOIN
    purchases p ON a.album_id = p.album_id
WHERE
    g.genre_name = 'Rock' -- Complex filtering on a joined table
GROUP BY
    a.album_title, g.genre_name
ORDER BY
    total_purchases DESC
LIMIT 10;

EXPLAIN (ANALYZE, VERBOSE, FORMAT JSON)
SELECT
    a.album_title,
    g.genre_name,
    COUNT(p.purchase_id) AS total_purchases
FROM
    albums a
JOIN
    genres g ON a.genre_id = g.genre_id
JOIN
    purchases p ON a.album_id = p.album_id
WHERE
    g.genre_name = 'Rock' -- Complex filtering on a joined table
GROUP BY
    a.album_title, g.genre_name
ORDER BY
    total_purchases DESC
LIMIT 10;