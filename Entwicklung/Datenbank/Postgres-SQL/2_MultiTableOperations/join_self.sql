SET search_path TO music_store;

-- Find all parent-child company branches
SELECT
    Child.branch_name AS "Branch Name",
    Parent.branch_name AS "Parent Branch Name",
    Child.city AS "Child City"
FROM
    company_branches AS Child
INNER JOIN
    company_branches AS Parent ON Child.parent_branch_id = Parent.branch_id;