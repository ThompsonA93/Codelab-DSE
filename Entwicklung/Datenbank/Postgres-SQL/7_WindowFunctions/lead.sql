SET search_path TO music_store;


-- Window functions calculate results across table rows related to the current row, without grouping them
-- Lead Window Functions retrieves a value relative to the position in the set. It is the opposite of lag, which serves the previous value.

-- For each album by an artist, retrieve the release years of the current and the next album
/*
album_title,                artist_id,  release_year,   next_album_year
A Night at the Opera,       12,         1975,           1977
News of the World,          12,         1977,           1978
Jazz,                       12,         1978,           1991
Innuendo,                   12,         1991,           2006
...
*/
SELECT
    album_title,
    artist_id,
    release_year,
    LEAD(release_year, 1) OVER (
        PARTITION BY artist_id
        ORDER BY release_year ASC
    ) AS next_album_year
FROM
    albums
ORDER BY
    artist_id, release_year;

