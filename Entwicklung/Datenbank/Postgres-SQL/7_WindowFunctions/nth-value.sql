SET search_path TO music_store;


-- Window functions calculate results across table rows related to the current row, without grouping them
-- FIRST_VALUE serves navigation to find the value of the very first row in a window.
-- LAST_VALUE finds the last value
-- NTH_VALUE finds the N'th value within the result set.

-- For each artist, fetch the X-th, chronological appearing album title
SELECT
    album_title,
    release_year,
    artist_id,
    FIRST_VALUE(album_title) OVER (
        PARTITION BY artist_id
        ORDER BY release_year ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS first_album_title
FROM
    albums
ORDER BY
    artist_id, release_year;

SELECT
    album_title,
    release_year,
    artist_id,
    LAST_VALUE(album_title) OVER (
        PARTITION BY artist_id
        ORDER BY release_year ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS most_recent_album
FROM
    albums
ORDER BY
    artist_id, release_year;

SELECT
    album_title,
    release_year,
    artist_id,
    NTH_VALUE(album_title, 2) OVER (    -- The 2nd album
        PARTITION BY artist_id
        ORDER BY release_year ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS second_album_title
FROM
    albums
ORDER BY
    artist_id, release_year;


-- The Window Frame is given through OVER, and must be refined for navigation or aggregate window functions
--      ROWS        BETWEEN     [start]     AND     [end]
-- [start]
--      CURRENT ROW: The current row, used for a forward-looking calculation on current and next rows
--      UNBOUNDED PRECEDING: Starting with the first row in the partition for a running total
--      N PRECEDING: Starting with the N'th row before the current row for a n-row moving average
-- [end]
--      CURRENT ROW: The current row, used for a running total
--      UNBOUNDED FOLLOWING: The last row in the partition
--      N FOLLOWING: Row ending the forward-looking calcuation


