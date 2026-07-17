CREATE SCHEMA IF NOT EXISTS music_store;

SET search_path TO music_store;

-- Used for Enum.sql
CREATE TYPE member_role AS ENUM (
    'Lead Vocalist',
    'Instrumentalist',
    'Songwriter',
    'Producer',
    'Manager'
);

CREATE TABLE artists (
    artist_id SERIAL PRIMARY KEY,
    artist_name VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);

CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE albums (
    album_id SERIAL PRIMARY KEY,
    album_title VARCHAR(200),
    release_year INTEGER,
    artist_id INTEGER NOT NULL REFERENCES artists(artist_id),
    genre_id INTEGER REFERENCES genres(genre_id)
);

CREATE TABLE tracks (
    track_id SERIAL PRIMARY KEY,
    track_title VARCHAR(200) NOT NULL,
    duration_seconds INTEGER,
    album_id INTEGER NOT NULL REFERENCES albums(album_id)
);

CREATE TABLE playlists (
    playlist_id SERIAL PRIMARY KEY,
    playlist_name VARCHAR(100) NOT NULL UNIQUE,
    creation_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE playlist_tracks (
    playlist_id INT NOT NULL,
    track_id INT NOT NULL,
    track_order INT,

    PRIMARY KEY (playlist_id, track_id),
    FOREIGN KEY (playlist_id) REFERENCES playlists (playlist_id),
    FOREIGN KEY (track_id) REFERENCES tracks (track_id)
);

CREATE TABLE company_branches (
    branch_id SERIAL PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    established_date DATE,
    parent_branch_id INT NULL,

    FOREIGN KEY (parent_branch_id) REFERENCES company_branches (branch_id)
);

CREATE TABLE purchases (
    purchase_id SERIAL PRIMARY KEY,
    album_id INT NOT NULL REFERENCES albums(album_id),
    artist_id INT NOT NULL REFERENCES artists(artist_id),
    amount NUMERIC(10, 2)
);

CREATE TABLE concerts (
    concert_id SERIAL PRIMARY KEY,
    artist_id INT NOT NULL REFERENCES artists(artist_id),
    venue_name VARCHAR(255),
    schedule tsrange
);

CREATE TABLE collaborations (
    collaboration_id SERIAL PRIMARY KEY,
    album_id INT NOT NULL REFERENCES albums(album_id),
    collaborator_ids INT[] NOT NULL
);

CREATE TABLE publishers (
    publisher_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    established_year INTEGER
);


-- Used for Enum.sql
CREATE TABLE artist_members (
    member_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    artist_id INTEGER NOT NULL REFERENCES artists(artist_id),
    member_name VARCHAR(100) NOT NULL,
    member_role member_role NOT NULL,
    tenure_dates DATERANGE,

    UNIQUE (artist_id, member_name)
);


-- Used for JSON.sql
CREATE TABLE album_metadata (
    album_metadata_id SERIAL PRIMARY KEY,
    album_id INT NOT NULL UNIQUE REFERENCES albums(album_id),
    details JSONB NOT NULL
);



-- Used for XML.sql
CREATE TABLE supplier_catalog (
    catalog_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(100),
    catalog_date DATE,
    product_xml XML NOT NULL
);