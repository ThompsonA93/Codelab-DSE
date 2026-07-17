SET search_path TO music_store;

SELECT
    t.artist_name,
    g.genre_name
FROM
    artists AS t
CROSS JOIN
    genres AS g;