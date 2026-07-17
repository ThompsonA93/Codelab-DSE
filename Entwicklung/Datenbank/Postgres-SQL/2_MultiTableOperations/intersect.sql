SET search_path TO music_store;

-- Find cities where both an artist and a branch exists.
SELECT
    city
FROM
    artists
WHERE
    city IS NOT NULL
INTERSECT
SELECT
    city
FROM
    company_branches
WHERE
    city IS NOT NULL;