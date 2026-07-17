SET search_path TO music_store;


-- Window functions calculate results across table rows related to the current row, without grouping them
-- Aggregate Window Functions use SUM, AVG, COUNT,..., to calculate the aggregate value alongside every row.

-- Find the release album of the first album written by an artist
/*
album_title,                release_year,   artist_id,  artist_first_album_year
The Dark Side of the Moon,  1973,           1,          1973
The Wall,                   1979,           1,          1973
Unforgettable,              1991,           10,         1991
A Night at the Opera,       1975,           12,         1975
News of the World,          1977,           12,         1975
...
*/
SELECT
    album_title,
    release_year,
    artist_id,
    MIN(release_year) OVER (
        PARTITION BY artist_id
    ) AS artist_first_album_year
FROM
    albums
ORDER BY
    artist_id, release_year;


-- Windows are usually defined over rows. To define it over a whole table, use an empty OVER() clause.
-- Select the average year for all albums including detailed data for each album
SELECT
    album_title,
    release_year,
    AVG(release_year) OVER () AS overall_avg_year
FROM
    albums
ORDER BY
    release_year DESC, album_title;

