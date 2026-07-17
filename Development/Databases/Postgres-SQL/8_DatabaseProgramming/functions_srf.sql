SET search_path TO music_store;

-- Set Returning Functions (SRF) return whole tables, not just variables.

CREATE FUNCTION get_top_albums(p_artist_name TEXT)
RETURNS TABLE (
    album_id INT,
    album_title VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
    RETURN QUERY
    SELECT a.album_id, a.album_title
    FROM albums a
    JOIN artists r ON a.artist_id = r.artist_id
    WHERE r.artist_name = p_artist_name
    LIMIT 5;
END;
$$;

-- How to use it:
SELECT * FROM get_top_albums('Queen');

DROP FUNCTION get_top_albums;