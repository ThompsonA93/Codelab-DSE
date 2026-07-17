SET search_path TO music_store;

SELECT
    t.artist_name,
    a.album_title
FROM
    artists AS t
LEFT JOIN
    albums AS a ON t.artist_id = a.artist_id;