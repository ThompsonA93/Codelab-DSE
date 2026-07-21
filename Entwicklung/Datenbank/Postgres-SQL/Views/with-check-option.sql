SET search_path TO music_store;

-- WITH CHECK OPTION ensures that data modified or inserted through a view must conform to the criteria in WHERE.
CREATE VIEW short_tracks_management AS
SELECT
    track_id,
    track_title,
    duration_seconds
FROM
    tracks
WHERE
    duration_seconds < 300
WITH CHECK OPTION;

SELECT * FROM short_tracks_management;

-- I.e. updating a track is now constrained to durations below 300.
-- 1. Allowed:
UPDATE
    short_tracks_management
SET
    duration_seconds = 250
WHERE
    track_title = 'Rolling in the Deep';

SELECT * FROM short_tracks_management WHERE track_title ='Rolling in the Deep';

-- Reverse Update
UPDATE
    short_tracks_management
SET
    duration_seconds = 221
WHERE
    track_title = 'Rolling in the Deep';

-- 2. Forbidden:
/*
UPDATE
    short_tracks_management
SET
    duration_seconds = 310
WHERE
    track_title = 'Rolling in the Deep';
 */