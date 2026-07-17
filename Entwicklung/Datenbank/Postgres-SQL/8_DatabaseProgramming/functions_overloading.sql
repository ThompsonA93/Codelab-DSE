SET search_path TO music_store;

-- PostgreSQL allows function overloading. I.e., functions can have the same name, but require different parameters
CREATE OR REPLACE FUNCTION add_artist(p_artist_name TEXT)
RETURNS VOID
VOLATILE
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO artists (artist_name)
    VALUES (p_artist_name);
END;
$$;

CREATE OR REPLACE FUNCTION add_artist(p_artist_name TEXT, p_city VARCHAR)
RETURNS VOID
VOLATILE
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO artists (artist_name, city)
    VALUES (p_artist_name, p_city);
END;
$$;

SELECT add_artist('Jethro Tull');
SELECT add_artist('Korn', 'Bakersfield');

SELECT * FROM artists WHERE artist_name = 'Jethro Tull';
SELECT * FROM artists WHERE artist_name = 'Korn';

DROP FUNCTION add_artist(text);
DROP FUNCTION add_artist(p_artist_name TEXT, p_city VARCHAR);