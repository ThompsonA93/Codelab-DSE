SET search_path TO music_store;

-- EXPLAIN ANALYZE returns information about how exactly a query is being executed.

EXPLAIN ANALYZE
SELECT SUM(p.amount)
FROM purchases p
WHERE p.artist_id = (
    SELECT artist_id
    FROM artists
    WHERE artist_name = 'Queen'
);

/* Returned information may look like this -- Data may differ
Finalize Aggregate  (cost=12628.51..12628.52 rows=1 width=32) (actual time=41.537..47.181 rows=1.00 loops=1)
  Buffers: shared hit=6371
  InitPlan 1
    ->  Seq Scan on artists  (cost=0.00..12.75 rows=1 width=4) (actual time=0.011..0.013 rows=1.00 loops=1)
          Filter: ((artist_name)::text = 'Queen'::text)
          Rows Removed by Filter: 26
          Buffers: shared hit=1
  ->  Gather  (cost=12615.54..12615.75 rows=2 width=32) (actual time=41.161..47.159 rows=3.00 loops=1)
        Workers Planned: 2
        Workers Launched: 2
        Buffers: shared hit=6371
        ->  Partial Aggregate  (cost=11615.54..11615.55 rows=1 width=32) (actual time=28.577..28.579 rows=1.00 loops=3)
              Buffers: shared hit=6370
              ->  Parallel Seq Scan on purchases p  (cost=0.00..11578.33 rows=14881 width=6) (actual time=0.016..26.480 rows=12357.00 loops=3)
                    Filter: (artist_id = (InitPlan 1).col1)
                    Rows Removed by Filter: 320976
                    Buffers: shared hit=6370
Planning:
  Buffers: shared hit=109 dirtied=1
Planning Time: 0.466 ms
Execution Time: 47.237 ms
*/
-- BASELINE QUERY INTERPRETATION (Execution Time: 47.237 ms)
-- 1. InitPlan 1 (0.013 ms):
--    -> Sequential Scan on 'artists'. This is the fast, efficient lookup for 'Queen's ID.
-- 2. Core Bottleneck - Parallelism (47.159 ms):
--    -> Workers Planned/Launched: 2. The database launches multiple processes (Workers) to read the massive 'purchases' table simultaneously.
--    -> Parallel Seq Scan on purchases p: The table is split into chunks, and each worker performs a full table scan on its chunk.
--    -> Filter: artist_id = (InitPlan 1).col1. Each worker reads hundreds of thousands of rows only to apply this filter, demonstrating significant wasted I/O and CPU time.
-- 3. Aggregation and Merging:
--    -> Partial Aggregate: Each worker calculates a local sum for its chunk of data.
--    -> Gather: The main process collects (gathers) the partial sums from all workers.
--    -> Finalize Aggregate: The final total SUM(amount) is computed.

-- This plan is the database's best attempt to overcome the missing index by using parallelism.


