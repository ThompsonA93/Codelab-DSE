SET search_path TO music_store;



SELECT COUNT(*) FROM publishers;
SELECT pg_size_pretty(pg_relation_size('publishers')) AS size;

DELETE FROM publishers WHERE publisher_id <= 125000;

SELECT COUNT(*) FROM publishers;
SELECT pg_size_pretty(pg_relation_size('publishers')) AS size;

VACUUM FULL publishers;

SELECT COUNT(*) FROM publishers;
SELECT pg_size_pretty(pg_relation_size('publishers')) AS size;

DROP TABLE publishers;