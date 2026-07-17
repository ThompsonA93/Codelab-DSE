SET search_path TO music_store;
-- GIN Tree (Generalized Inverted Index) is optimized for indexing and looking up collections of few but large elements in single columns
--      Extremely efficient for array-like structures like INT[] or TEXT[]: ["Aurora","Benedict","Curry"]
--      Commonly used with JSON/JSONB or TSVECTOR

-- Find all artists that have collaborated with the specific artist 17
EXPLAIN ANALYZE
SELECT
    collaboration_id
FROM
    collaborations
WHERE
    collaborator_ids @> ARRAY[17];

CREATE INDEX idx_collaborator_ids_gin ON collaborations USING GIN (collaborator_ids);

EXPLAIN ANALYZE
SELECT
    collaboration_id
FROM
    collaborations
WHERE
    collaborator_ids @> ARRAY[17];

DROP INDEX idx_collaborator_ids_gin;