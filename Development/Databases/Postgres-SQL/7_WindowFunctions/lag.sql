SET search_path TO music_store;


-- Window functions calculate results across table rows related to the current row, without grouping them
-- LAG is the opposite of LEAD, which returns the specific value of the previous row.

-- For each artist, fetch the first, chronological appearing album title
SELECT
    album_title,
    artist_id,
    release_year,
    LAG(release_year, 1) OVER (
        PARTITION BY artist_id
        ORDER BY release_year ASC
    ) AS previous_album_year
FROM
    albums
ORDER BY
    artist_id, release_year;


