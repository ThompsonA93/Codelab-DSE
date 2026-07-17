SET search_path TO music_store;


-- Find all Albums that belong to the genre 'Metal'.
SELECT
    album_title,
    release_year
FROM
    albums
WHERE
    genre_id = (
        SELECT genre_id
        FROM genres
        WHERE genre_name = 'Metal'
    );

