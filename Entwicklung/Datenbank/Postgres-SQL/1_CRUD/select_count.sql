SET search_path TO music_store;

SELECT
    COUNT(album_id) AS albums_pre_2000_count
FROM
    albums
WHERE
    release_year < 2000;