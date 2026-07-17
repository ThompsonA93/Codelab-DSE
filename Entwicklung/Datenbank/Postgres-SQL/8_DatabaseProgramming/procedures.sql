SET search_path TO music_store;

-- Procedures are designed to execute a sequence of queries, involving transaction control.
--      Defines transaction control via COMMIT, ROLLBACK and persistence
--      May return data using OUT
--      Can run transaction commands with COMMIT and ROLLBACK
--      Called via CALL

CREATE OR REPLACE PROCEDURE record_purchase(
    p_album_id INT,
    p_artist_id INT,
    p_amount NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO purchases (album_id, artist_id, amount)
    VALUES (p_album_id, p_artist_id, p_amount);

    RAISE NOTICE 'Recorded new purchase for Album ID % and Artist ID % for amount $%',
                 p_album_id, p_artist_id, p_amount;
EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'Purchase failed: Album or Artist ID does not exist.';
END;
$$;

-- Call the procedure with actual values
CALL record_purchase(
    1,
     1,
     159.99
);


CALL record_purchase(
    p_artist_id => 3,       -- PL/pgSQL uses => instead of =
    p_album_id => 3,
    p_amount => 159.99
);

SELECT * FROM purchases WHERE amount = 159.99;

DROP PROCEDURE record_purchase;