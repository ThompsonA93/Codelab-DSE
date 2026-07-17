SET search_path TO music_store;

SELECT
    artist_name
FROM
    artists
WHERE
    artist_name IS NOT NULL
EXCEPT
SELECT
    t1.artist_name
FROM
    artists AS t1
INNER JOIN
    albums AS t2 ON t1.artist_id = t2.artist_id;