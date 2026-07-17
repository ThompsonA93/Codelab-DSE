SET search_path TO music_store;

-- A composite index is a multi-column index.
-- An index on (A,B,C) sorts columns following A, then B, then C.

EXPLAIN ANALYZE
SELECT *
FROM concerts
WHERE artist_id = 12 AND venue_name = 'Venue_15';

EXPLAIN ANALYZE
SELECT venue_name, schedule
FROM concerts
WHERE artist_id = 12;

CREATE INDEX idx_concerts_artist_venue ON concerts (artist_id, venue_name);

EXPLAIN ANALYZE
SELECT *
FROM concerts
WHERE artist_id = 12 AND venue_name = 'Venue_15';

EXPLAIN ANALYZE
SELECT venue_name, schedule
FROM concerts
WHERE artist_id = 12;

DROP INDEX idx_concerts_artist_venue;