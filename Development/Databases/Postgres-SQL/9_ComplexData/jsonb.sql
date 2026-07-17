SET search_path TO music_store;


INSERT INTO album_metadata (album_id, details)
VALUES (
    (SELECT album_id FROM albums WHERE album_title = 'Led Zeppelin IV' LIMIT 1),
    '{
        "critics_score": 9.5,
        "is_remastered": false,
        "streaming_stats": {
            "spotify": 850000000,
            "apple_music": 400000000
        },
        "edition": "Original 1971 Release"
    }'::jsonb
);

INSERT INTO album_metadata (album_id, details)
VALUES (
    (SELECT album_id FROM albums WHERE album_title = '21' LIMIT 1),
    '{
        "critics_score": 9.9,
        "awards": ["Grammy Album of the Year", "Brit Award"],
        "sales_units": 31000000,
        "format": "CD"
    }'::jsonb
);

INSERT INTO album_metadata (album_id, details)
VALUES (
    (SELECT album_id FROM albums WHERE album_title = 'The Dark Side of the Moon' LIMIT 1),
    '{
        "critics_score": 10.0,
        "time_on_charts_weeks": 950,
        "recording_studio": "Abbey Road",
        "format": ["Vinyl", "SACD"],
        "streaming_stats": {
            "spotify": 1200000000,
            "youtube": 500000000
        }
    }'::jsonb
);


SELECT
    a.album_title,
    am.details ->> 'critics_score' AS score,
    am.details -> 'streaming_stats' AS streaming_data
FROM albums a
JOIN album_metadata am ON a.album_id = am.album_id;

SELECT
    a.album_title,
    am.details ->> 'edition' AS edition_info
FROM albums a
JOIN album_metadata am ON a.album_id = am.album_id
WHERE am.details ->> 'edition' ILIKE '%original%';

SELECT
    a.album_title,
    am.details
FROM albums a
JOIN album_metadata am ON a.album_id = am.album_id
WHERE am.details ?& ARRAY['critics_score', 'sales_units'];


SELECT
    a.album_title,
    (am.details #>> '{streaming_stats, spotify}')::bigint AS spotify_streams -- Cast to BIGINT for comparison
FROM albums a
JOIN album_metadata am ON a.album_id = am.album_id
WHERE am.details #>> '{streaming_stats, spotify}' IS NOT NULL
ORDER BY spotify_streams DESC
LIMIT 1;

CREATE INDEX idx_album_metadata_details_gin ON album_metadata USING GIN (details);
CREATE INDEX idx_album_metadata_spotify_streams ON album_metadata USING GIN ((details -> 'streaming_stats') jsonb_path_ops);

DROP TABLE album_metadata CASCADE;
