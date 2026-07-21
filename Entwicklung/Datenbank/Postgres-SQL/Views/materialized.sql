SET search_path TO music_store;

-- MATERIALIZED is a option with multiple effects
--      Result-set is physically saved on disk
--      Queries are run against this stored result-set, making the query very fast
--      Result sets are only updated on refresh operations
--      Theory-wise, it's non-updatable, but refreshable


CREATE MATERIALIZED VIEW genre_summary AS
SELECT
    g.genre_name,
    COUNT(t.track_id) AS total_tracks,
    SUM(t.duration_seconds) AS total_duration_seconds
FROM
    genres g
JOIN
    albums a ON g.genre_id = a.genre_id
JOIN
    tracks t ON a.album_id = t.album_id
GROUP BY
    g.genre_name;

SELECT * FROM genre_summary;

-- To update data, update the base tables, then call the fresh action.
UPDATE
    genres
SET
    genre_name = 'Heavy Metal'
WHERE
    genre_name = 'Metal';

REFRESH MATERIALIZED VIEW genre_summary;

SELECT * FROM genre_summary;


-- Revert Update
UPDATE
    genres
SET
    genre_name = 'Metal'
WHERE
    genre_name = 'Heavy Metal';

REFRESH MATERIALIZED VIEW genre_summary;
