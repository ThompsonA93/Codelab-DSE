SET search_path TO music_store;

-- Find name and genre of all artists who have released albums after 2000.
WITH Recent_Albums AS (
    SELECT
        artist_id,
        genre_id
    FROM
        albums
    WHERE
        release_year > 2000
)

SELECT
    a.artist_name,
    g.genre_name
FROM
    Recent_Albums AS ra
JOIN
    artists AS a ON ra.artist_id = a.artist_id
JOIN
    genres AS g ON ra.genre_id = g.genre_id
GROUP BY 1, 2;