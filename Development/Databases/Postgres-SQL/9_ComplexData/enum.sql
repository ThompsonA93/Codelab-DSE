SET search_path TO music_store;

DO $$
DECLARE
    queen_id INT;
    taylor_id INT;
BEGIN
    SELECT artist_id INTO queen_id FROM artists WHERE artist_name = 'Queen';
    SELECT artist_id INTO taylor_id FROM artists WHERE artist_name = 'Taylor Swift';

    INSERT INTO artist_members (artist_id, member_name, member_role, tenure_dates) VALUES
    (queen_id, 'Freddie Mercury', 'Lead Vocalist', '[1970-04-01, 1991-11-24]'::daterange);

    INSERT INTO artist_members (artist_id, member_name, member_role, tenure_dates) VALUES
    (queen_id, 'Brian May', 'Instrumentalist', '[1970-04-01, infinity)'::daterange);

    INSERT INTO artist_members (artist_id, member_name, member_role, tenure_dates) VALUES
    (queen_id, 'John Deacon', 'Instrumentalist', '[1971-02-01, 1997-01-01)'::daterange);

    INSERT INTO artist_members (artist_id, member_name, member_role, tenure_dates) VALUES
    (queen_id, 'Jim Beach', 'Manager', '[1978-01-01, infinity)'::daterange);

    INSERT INTO artist_members (artist_id, member_name, member_role, tenure_dates) VALUES
    (taylor_id, 'Jack Antonoff', 'Producer', '[2013-01-01, infinity)'::daterange);

    INSERT INTO artist_members (artist_id, member_name, member_role, tenure_dates) VALUES
    (taylor_id, 'Liz Rose', 'Songwriter', '[2006-01-01, 2010-01-01)'::daterange);
END $$;


SELECT
    a.artist_name,
    am.member_name,
    am.tenure_dates
FROM artist_members am
JOIN artists a ON am.artist_id = a.artist_id
WHERE
    am.tenure_dates @> '1995-06-01'::DATE;

SELECT
    'Overlap exists' AS result
FROM artist_members fm
JOIN artist_members jd ON fm.artist_id = jd.artist_id
WHERE
    fm.member_name = 'Freddie Mercury' AND
    jd.member_name = 'John Deacon' AND
    fm.tenure_dates && jd.tenure_dates;
