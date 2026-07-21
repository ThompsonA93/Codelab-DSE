SET search_path to music_store;

-- ANALYZE scans every table to read and update statistics.
ANALYZE;

-- Print information of a given table
ANALYZE VERBOSE purchases;

-- Print information of a given column
ANALYZE VERBOSE albums(album_title, genre_id);