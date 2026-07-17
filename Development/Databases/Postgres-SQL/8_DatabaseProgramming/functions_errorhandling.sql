SET search_path TO music_store;

-- Error handling define resolutions for exceptions. Per default, transactions that crash are rolled back.
--      EXCEPTION is defined between BEGIN and END
--      WHEN [violation] THEN is a specific case following xyz
--      WHEN OTHERS THEN is a default case

CREATE OR REPLACE FUNCTION add_artist_safe(p_artist_name TEXT)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO artists (artist_name)
    VALUES (p_artist_name);
    RETURN TRUE;
EXCEPTION
    WHEN unique_violation THEN -- unique_violation is a exception class for insert/update violating unique or primary key constraints
        RAISE NOTICE 'Artist "%" already exists. Insertion skipped.', p_artist_name;
        RETURN FALSE;
    WHEN OTHERS THEN
        RAISE EXCEPTION 'An unexpected error occurred during artist insertion: %', SQLERRM;
END;
$$;

SELECT add_artist_safe('Queen');            -- Returns "False"
SELECT add_artist_safe('Andrea Bodner');    -- Returns "True"

DELETE FROM artists WHERE artist_name = 'Andrea Bodner';
DROP FUNCTION add_artist_safe(p_artist_name TEXT);
