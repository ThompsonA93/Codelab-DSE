SET search_path TO music_store;

-- List all cities where either a company or artist exists.
SELECT
    city,
    branch_name
FROM
    company_branches
WHERE
    city IS NOT NULL
UNION
SELECT
    city,
    artist_name
FROM
    artists
WHERE
    city IS NOT NULL
ORDER BY
    city;