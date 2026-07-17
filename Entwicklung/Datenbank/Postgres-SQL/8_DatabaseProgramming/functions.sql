SET search_path TO music_store;

-- Functions are designed to calculate and return a value, commonly used in SELECT queries.
--      Must return a value or collection of values given RETURNS
--      Must run inside an existing transaction
--      Called by a SELECT statement
-- https://www.postgresql.org/docs/current/sql-createfunction.html

CREATE FUNCTION get_album_count_sql(p_artist_id INTEGER)
RETURNS BIGINT
STABLE
LANGUAGE sql        -- Given SQL, it is not necessary to DECLARE, BEGIN or END.
AS $$
    SELECT COUNT(*)
    FROM albums
    WHERE artist_id = p_artist_id;
$$;                 -- The mandatory return value is automatically returned by the function as the count in form of BIGINT.

SELECT get_album_count_sql(12);


-- Queries can run within a codeblock either static or dynamic.
--      Static: The query is hardcoded in the code block
--      Dynamic: The query is injected into the code block (Danger: SQL Injection)
CREATE FUNCTION get_album_count_static(p_artist_id INTEGER)
RETURNS BIGINT
STABLE
LANGUAGE plpgsql AS $$  -- Given PLpgsql, it is mandatory to use BEGIN and END, and an optional DECLARE for variables.
DECLARE
    v_count BIGINT;     -- Declares a variable to use within the code block
BEGIN
    SELECT COUNT(*) INTO v_count    -- Stores the result locally inside the variable, within the scope of function
    FROM albums
    WHERE artist_id = p_artist_id;
    RETURN v_count;                 -- Ends the code block and writes to the global value, which is a BIGINT.
END;
$$;

SELECT get_album_count_static(12);



CREATE FUNCTION get_row_count_dynamic(p_table_name TEXT)
RETURNS BIGINT
STABLE
LANGUAGE plpgsql AS $$
DECLARE
    v_count BIGINT;
    v_sql   TEXT;
BEGIN
    v_sql := 'SELECT COUNT(*) FROM ' || quote_ident(p_table_name);
    EXECUTE v_sql INTO v_count;
    RETURN v_count;
END;
$$;

SELECT get_row_count_dynamic('artists');
SELECT get_row_count_dynamic('tracks');


DROP FUNCTION get_album_count_sql;
DROP FUNCTION get_album_count_static;
DROP FUNCTION get_row_count_dynamic;
