SET search_path TO music_store;


-- Window functions calculate results across table rows related to the current row, without grouping them
-- Ranking Windows assign a rank to each row based on the order by clause. Commonly used for finding the top x items

-- For each Artist, rank albums chronologically
/*
album_title,                release_year,   artist_id,  chronological_album_number
The Dark Side of the Moon,  1973,           1,          1
The Wall,                   1979,           1,          2
Unforgettable,              1991,           10,         1
A Night at the Opera,       1975,           12,         1
News of the World,          1977,           12,         2
Jazz,                       1978,           12,         3
*/
SELECT
    album_title,
    release_year,
    artist_id,
    DENSE_RANK() OVER (
        PARTITION BY artist_id
        ORDER BY release_year ASC
    ) AS chronological_album_number
FROM
    albums
ORDER BY
    artist_id, release_year;


-- There is a difference in using DENSE_RANK and RANK, the latter skipping duplicate values. Consider the following example.
SELECT
    album_title,
    release_year,
    RANK() OVER (ORDER BY release_year DESC) AS rnk,
    DENSE_RANK() OVER (ORDER BY release_year DESC) AS dense_rnk
FROM
    albums
WHERE artist_id = 12
ORDER BY
    release_year DESC;
