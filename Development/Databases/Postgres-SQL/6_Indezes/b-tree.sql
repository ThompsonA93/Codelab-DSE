SET search_path TO music_store;

-- B-Tree index (Balanced Tree) is the default index.
--      Efficient for Equality lookups (WHERE x = 1)
--      Finding ranges (WHERE x BETWEEN y AND z)

EXPLAIN ANALYZE
SELECT SUM(p.amount)
FROM purchases p
WHERE p.artist_id = (
    SELECT artist_id
    FROM artists
    WHERE artist_name = 'Queen'
);

CREATE INDEX idx_purchases_artist_id ON purchases (artist_id);

EXPLAIN ANALYZE
SELECT SUM(p.amount)
FROM purchases p
WHERE p.artist_id = (
    SELECT artist_id
    FROM artists
    WHERE artist_name = 'Queen'
);

/** The data now looks different to the example posed in explain.sql
Aggregate  (cost=7319.67..7319.68 rows=1 width=32) (actual time=18.388..18.392 rows=1.00 loops=1)
  Buffers: shared hit=6351 read=34
  InitPlan 1
    ->  Seq Scan on artists  (cost=0.00..12.75 rows=1 width=4) (actual time=0.016..0.019 rows=1.00 loops=1)
          Filter: ((artist_name)::text = 'Queen'::text)
          Rows Removed by Filter: 26
          Buffers: shared hit=1
  ->  Bitmap Heap Scan on purchases p  (cost=401.21..7217.63 rows=35714 width=6) (actual time=2.323..13.350 rows=37071.00 loops=1)
        Recheck Cond: (artist_id = (InitPlan 1).col1)
        Heap Blocks: exact=6350
        Buffers: shared hit=6351 read=34
        ->  Bitmap Index Scan on idx_purchases_artist_id  (cost=0.00..392.28 rows=35714 width=0) (actual time=1.564..1.564 rows=37071.00 loops=1)
              Index Cond: (artist_id = (InitPlan 1).col1)
              Index Searches: 1
              Buffers: shared hit=1 read=34
Planning:
  Buffers: shared hit=15 read=1
Planning Time: 0.401 ms
Execution Time: 18.444 ms
*/
-- EXPLAIN ANALYZE INTERPRETATION (Execution Time: 18.444 ms)
-- 1. InitPlan 1 (0.019 ms):
--    -> Sequential Scan on 'artists'. The database reads the small artists table
--       from start to finish to quickly find the 'Queen' ID. This remains the most efficient method for this tiny table.
-- 2. Data Retrieval Strategy (13.350 ms):
--    -> Bitmap Index Scan: The index (idx_purchases_artist_id) is scanned to find the locations of 37,071 matching IDs. (1.564 ms)
--    -> Bitmap Heap Scan: The actual purchase data (the amount) is retrieved from the main table (heap) using the locations found by the index.
--    -> Buffers: shared hit=6351 read=34. As before, 6,351 data blocks were found in memory (cache), and only 34 required disk I/O. This ensures the majority of the retrieval is extremely fast.
-- 3. Aggregate (18.392 ms):
--    -> This is the final step where the SUM(amount) calculation is performed on the 37,071 retrieved rows. Its actual time (18.392 ms) aligns closely with the total Execution Time, showing the bulk of the time was spent retrieving and summing the data efficiently.

-- Revert index creation
DROP INDEX idx_purchases_artist_id;
