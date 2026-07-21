SET search_path TO music_store;


-- Find the names of all artists who have released at least 2 albums.
SELECT
    a.artist_name
FROM
    (
        SELECT
            artist_id,
            COUNT(album_id) AS total_albums
        FROM
            albums
        GROUP BY
            artist_id
        HAVING
            COUNT(album_id) >= 2
    ) AS album_counts
JOIN
    artists AS a ON album_counts.artist_id = a.artist_id
ORDER BY
    a.artist_name;