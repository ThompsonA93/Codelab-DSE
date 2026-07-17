SET search_path TO music_store;

-- Hash index is a index that is extremely fast on equality operators.
--      Hash Table structures are unsorted
--      Extremely fast on equality checks, ONLY for equality ( = ) checks
--      Marginally faster than B-Tree for simple reads, pending on the B-Tree depth

EXPLAIN ANALYZE
SELECT
    COUNT(*)
FROM
    purchases
WHERE
    amount = 15.00;

CREATE INDEX idx_purchases_amount_hash
ON purchases USING HASH (amount);

EXPLAIN ANALYZE
SELECT
    COUNT(*)
FROM
    purchases
WHERE
    amount = 15.00;

-- Revert index creation
DROP INDEX idx_purchases_amount_hash;