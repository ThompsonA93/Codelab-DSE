SET search_path TO music_store;

-- Non-updatable Views: Implicitely, views that contain the following paradigms can not self-upate.
--      Joins
--      Aggregate Functions (Sum, Count, Avg, Max, ...)
--      Groups (Group By, Having)
--      Set operators (Union, Intersect, Except)
--      Subqueries or CTEs

CREATE VIEW detailed_track_info AS
SELECT
    t.track_title,
    t.duration_seconds,
    a.album_title,
    art.artist_name,
    g.genre_name,
    a.release_year
FROM
    tracks t
JOIN
    albums a ON t.album_id = a.album_id
JOIN
    artists art ON a.artist_id = art.artist_id
LEFT JOIN
    genres g ON a.genre_id = g.genre_id;

SELECT * FROM detailed_track_info WHERE artist_name = 'Queen';

-- I.e. trying to update this view will fail, given the multi-table join.
/*
UPDATE
    detailed_track_info
SET
    genre_name = 'Progressive Rock'
WHERE
    track_title = 'Stairway to Heaven';
*/
-- Updating this view may depend on the SQL-Dialect. Ways are
--      PSQL: `INSTEAD OF` Triggers (See 7_DatabaseProgramming)



