SET search_path TO music_store;

SELECT
    track_title,
    duration_seconds AS track_duration_in_seconds
FROM
    tracks
WHERE
    duration_seconds > 300;