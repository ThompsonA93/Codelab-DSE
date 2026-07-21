SET search_path TO music_store;

SELECT
    city,
    COUNT(branch_id) AS number_of_branches
FROM
    company_branches
GROUP BY
    city
HAVING
    COUNT(branch_id) > 1;