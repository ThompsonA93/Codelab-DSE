SET search_path TO music_store;

-- Updatable Views: Implicitely, views that contain the following paradigms can self-update.
--      References only one base table
--      Includes a primary key
--      Contains no aggregations, Joins, Groups, ...

CREATE VIEW long_tracks_view AS
SELECT
    track_id,
    track_title,
    duration_seconds,
    album_id
FROM
    tracks
WHERE
    duration_seconds > 300;

SELECT * FROM long_tracks_view;

-- I.e., Updating this view will update the base table 'Tracks'
UPDATE
    long_tracks_view
SET
    duration_seconds = 516
WHERE
    track_title = 'Master of Puppets';

SELECT * FROM long_tracks_view where track_title = 'Master of Puppets';
SELECT * FROM tracks WHERE track_title = 'Master of Puppets';

-- Revert to original state
UPDATE
    long_tracks_view
SET
    duration_seconds = 515
WHERE
    track_title = 'Master of Puppets';