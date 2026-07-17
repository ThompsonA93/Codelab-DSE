SET search_path TO music_store;

SELECT
    a.album_title,
    t.artist_name
FROM
    albums AS a
INNER JOIN
    artists AS t ON a.artist_id = t.artist_id;
