SET search_path TO music_store;

SELECT
    track_title,
    duration_seconds
FROM
    tracks
WHERE
    duration_seconds IS NOT NULL
ORDER BY
    duration_seconds DESC
LIMIT 5;