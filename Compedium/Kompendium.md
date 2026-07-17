# Kompendium

Dieses Kompendium ist mit [Obsidian](https://obsidian.md/) kompatibel oder kann auch ohne dieses Programm verwendet werden.

Öffne den Ordner als neuen Vault oder mit einem Editor deiner Wahl.


## Roadmap


1. [[Datenbankinstallation]]
    1. Informationsspeichersysteme: MS Access
    2. Installation eines DBMS: Postgres mit pgAdmin
    3. Service-Containerisierung: Postgres mit Docker
    4. GUI Ökosystem: pgAdmin, DBeaver, Datagrip
    5. Command Line Interface: psql-Befehle wie \l, \dt, \d, ...
2. [[Grundlagen von SQL]]
	1. Datenformate: Typen, Strings, Numbers, Dates
	2. Relationales Model: Schema, Tabellen, Indezes, Domänen, Entitäten, Attribute, Relationen
	3. Create, Read, Update, Delete (CRUD): CREATE, INSERT, SELECT, UPDATE ... SET, ALTER, DROP, FROM, WHERE, LIMIT, OFFSET, DELETE, AS, TRUNCATE, DEFAULT, CASCADE
    4. Filtern und Sortieren: LIKE, ILIKE, IN, BETWEEN, ORDER BY, DISTINCT, IS NULL
    5. Aggregationen: COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING
    6. Constraints: NOT NULL, UNIQUE, CHECK, 
3. [[Datenbankmodellierung]]
	1. Entity-Relationship Diagramme: ERD in Chen-Notation
	2. Kardinalitäten von Beziehungen: 1:1, 1:m, n:m
	3. Referentielle Integrität: PRIMARY KEY, REFERENCES (ON ... CASCADE)
	4. Joins: INNER, LEFT, RIGHT, OUTER, SELF, ON, USING
    5. Normalisierung: 1NF, 2NF, 3NF
4. [[Fortgeschrittenes SQL]]
    1. Views: VIEW, MATERIALIZED VIEW
	2. Subqueries & CTEs: Nested Queries, WITH, EXISTS
	3. Window Functions: OVER (PARTITION BY ... ORDER BY ... ), ROW_NUMBER, RANK, LEAD, LAG
	4. Rekursive Queries: WITH RECURSIVE
	5. Mengenoperationen: UNION, INTERSECT, EXCEPT
    6. JSON & Arrays: jsonb, Operatoren, Funktionen, ANY, ALL
    7. Datum und Stringfunktionen: EXTRACT, DATE_PART, UPPER, LOWER
    8. Test und Validation: pgTap
5. [[Physisches Datenbankdesign]]
    1. Transaktionen: BEGIN, COMMIT, ROLLBACK, FOR UPDATE, SKIP LOCKED
    2. Transaktionseigenschaften: Isolationslevel, Dirty Reads, Non-Repeatable Reads
    3. Query Execution Pipeline: Parse, Plan, Execute
    4. Transaktionsanalyze: EXPLAIN, EXPLAIN ANALYZE
    5. Indezes & Typen: INDEX, USING, B-Tree, GIN, GIST
6. [[Datenbankprogrammierung]]
	1. Kontrollflüsse: CASE WHEN ... THEN ... ELSE ... END, COALESCE, CAST, INSER ... ON CONFLICT, RETURNING
    2. Funktionen mit PL/pgSQL: FUNCTION, PERFORM, RETURNS, LANGUAGE, AS \$\$, DECLARE, BEGIN ... END
    3. Prozeduren: PROCEDURE
    4. Trigger: TRIGGER, BEFORE, AFTER, INSTEAD OF, FOR EACH ROW, WHEN
    5. Errorhandling: RAISE
7. [[Datenbankadministration]]
    1. User, Rollen, Privilegien: CREATE/ALTER ROLE, REVOKE, GRANT
    2. Multi-Vercion Concurrency Control und Table Bloat: VACUUM
    3. Backup-Strategien: Point-in-Time Recovery, pg_dump, pg_basebackup
    4. Write-Ahead Logs: pg_waldump
    5. Replikationsmodelle: Primary-Replica, Read-Replica, Failovers
    6. Skalierung und Partitionierung: CREATE TABLE ... PARTITION BY, CockroachDB
    7. Monitoring: pg_stat_statements
    8. Observability: Prometheus, Grafana
8. [[Applikationsintegration]]
    1. Entwicklung modularer Komponenten: Clean Arch-Entwicklung des Backends
    2. Applikationstreiber: Java mit pg-driver
    3. Connection Pooling: pgBouncer
    4. Abfragensicherheit: SQL-Injection, Parametrisierte Queries
    5. Object-Relational Mapper: Hibernate
    6. Migrationsprozess: Migration einer DB v1 zu v2
    7. Versionierungssysteme: Git mit Github
9.  [[Systemarchitektur]]
    1. Unified Modelling Language Diagramme.
	2. Business versus Application Logic: Anemic Domains, Rich Databases
	3. Network Topologies: Chatty vs Chunky I/O
	4. Database Access Patterns: Table, View, Function, Procedure, API-Mapping
	5. Distributed Data Patterns: CQRS, Saga, Outbox
10.  [[Nicht-relationale Datenbanken]]
    1. Key-Value Stores: Redis
    2. Column-Oriented Datenbanken: Apache Cassandra
    3. Time-Series Datenbanken: TimescaleDB
    4. Spatiale Datenbanken: PostGIS
    5. Graph Datenbanken: Postgres v19+
    6. Objektspeicher: MinIO
11. [[Data Warehousing]]
    1. Prinzipien von OLAP vs OLTP: Row-oriented vs Column-Oriented DB
    2. Prinzipien von ETL: ETL vs ELT
    3. Dimensionales Modellieren: Star Schema, Snowflake Schema
    4. Analytisches Modellieren: dbt, dbt-core
    5. Data Quality: Data lineage, testing, scheduling
12. [[Cloud Computing]]
    1. Prinzipien von XaaS: SaaS, PaaS, IaaS
    2. Serverless Data Warehousing: BigQuery
    3. Serverless App Pipeline: Cloud Run
