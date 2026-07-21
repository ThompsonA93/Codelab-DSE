SET search_path TO music_store;

-- Get all company_branches that report to "Canada National HQ", directly and indirectly.
WITH RECURSIVE company_reporting_hierarchy AS (
    SELECT
        branch_id,
        branch_name,
        parent_branch_id
    FROM
        company_branches
    WHERE
        branch_name = 'Canada National HQ'
    UNION ALL
    SELECT
        b.branch_id,
        b.branch_name,
        b.parent_branch_id
    FROM
        company_branches AS b
    INNER JOIN
        company_reporting_hierarchy AS sos
            ON b.parent_branch_id = sos.branch_id
)

SELECT
    branch_id,
    branch_name
FROM
    company_reporting_hierarchy
ORDER BY
    branch_id;