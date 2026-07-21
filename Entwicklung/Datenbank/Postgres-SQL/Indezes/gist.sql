SET search_path TO music_store;

-- GiST (Generalized Search Tree) handles non-linear, multi-dimensional and complex data structures in bounding boxes containing data points (imagine geometry)
--      Commonly used for geospatial data (box, polygon)
--      Can index a column defined as range (tsrange) and quickly find ranges that overlap, contained with, or adjacent to the range.
--      Used for full-text search on text columns and full-text indexing (tsvector)


-- This query looks for any concert that occurs during this two-day period
EXPLAIN ANALYZE
SELECT
    concert_id, artist_id, venue_name
FROM
    concerts
WHERE
    schedule && tsrange('2025-05-10 00:00:00'::timestamp, '2025-05-12 00:00:00'::timestamp);

CREATE INDEX idx_concerts_schedule_gist
ON concerts USING GIST (schedule);

EXPLAIN ANALYZE
SELECT
    concert_id, artist_id, venue_name
FROM
    concerts
WHERE
    schedule && tsrange('2025-05-10 00:00:00'::timestamp, '2025-05-12 00:00:00'::timestamp);

-- Revert index creation
DROP INDEX idx_concerts_schedule_gist;