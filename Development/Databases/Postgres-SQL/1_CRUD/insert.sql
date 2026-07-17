SET search_path TO music_store;

INSERT INTO artists(artist_name) VALUES
('Pink Floyd'),
('Lauryn Hill'),
('Eminem'),
('The Smashing Pumpkins'),
('Tool'),
('The Pixies'),
('The Beach Boys'),
('The velvet Underground'),
('Green Day'),
('Nat King Cole'),
('System of a Down');

INSERT INTO artists (artist_name, city) VALUES
('Queen', 'London'),
('Metallica', 'Los Angeles'),
('Jimi Hendrix', NULL),
('Michael Jackson', 'Gary'),
('The Rolling Stones', 'London'),
('Vivaldi', 'Venice'),
('Norah Jones', NULL),
('Led Zeppelin', 'London'),
('Eagles', 'Los Angeles'),
('John Lennon', 'Liverpool'),
('Nirvana', 'Aberdeen'),
('Bob Dylan', 'Duluth'),
(NULL, 'New York'),
(NULL, 'Manchester'),
(NULL, NULL),
(NULL, 'Rome'),
(NULL, 'Berlin'),
(NULL, 'Toronto'),
('Taylor Swift', 'West Reading'),
('Drake', 'Toronto'),
('Billie Eilish', 'Los Angeles'),
('Adele', 'London'),
('Ed Sheeran', 'Halifax'),
('Ariana Grande', 'Boca Raton'),
('Elton John', 'Pinner'),
('Madonna', 'Bay City'),
('Beyoncé', 'Houston'),
('Rihanna', 'Saint Michael'),
('Kendrick Lamar', 'Compton'),
('The Beatles', 'Liverpool'),
('Elvis Presley', 'Tupelo'),
('Mozart', 'Salzburg'),
('Ludwig van Beethoven', 'Bonn'),
('Frank Sinatra', 'Hoboken'),
('David Bowie', 'London'),
('Prince', 'Minneapolis'),
('Miles Davis', 'Alton'),
('Johnny Cash', 'Kingsland'),
('Ray Charles', 'Albany'),
('Bob Marley', 'Nine Mile'),
('The Clash', 'London'),
('Wu-Tang Clan', 'Staten Island'),
('Daft Punk', 'Paris'),
('Tupac Shakur', 'New York'),
('The Cure', 'Crawley'),
('Radiohead', 'Abingdon'),
('U2', 'Dublin'),
('AC/DC', 'Sydney'),
('Guns N Roses', 'Los Angeles'),
('Iron Maiden', 'London'),
('Rush', 'Toronto'),
('R.E.M.', 'Athens'),
('Red Hot Chili Peppers', 'Los Angeles'),
('Oasis', 'Manchester'),
('Blur', 'London'),
('The Smiths', 'Manchester'),
('J.S. Bach', 'Eisenach'),
('Chopin', 'Żelazowa Wola'),
('Puccini', 'Lucca'),
('Ella Fitzgerald', 'Newport News'),
('Louis Armstrong', 'New Orleans'),
('Aretha Franklin', 'Memphis'),
('SZA', NULL),
('Post Malone', 'Syracuse'),
('Halsey', 'Washington'),
(NULL, 'Seattle'),
(NULL, 'Boston'),
(NULL, 'Austin'),
('Enya', 'Gweedore'),
('Avicii', 'Stockholm'),
('Imagine Dragons', 'Las Vegas'),
('Coldplay', 'London');


INSERT INTO genres (genre_name) VALUES
('Rock'),
('Pop'),
('Metal'),
('Country'),
('Blues'),
('Jazz'),
('Classical'),
('Hip Hop'),
('Folk-Rock'),
('R&B'),
('Electronic'),
('Indie'),
('Punk'),
('Reggae'),
('Gospel'),
('Soul'),
('Techno'),
('House'),
('Ambient'),
('World Music'),
('Soundtrack'),
('New Age'),
('Disco'),
('Ska'),
('Spoken Word');

INSERT INTO albums (album_title, release_year, artist_id, genre_id) VALUES
('Led Zeppelin IV', 1971, (SELECT artist_id FROM artists WHERE artist_name = 'Led Zeppelin'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('21', 2011, (SELECT artist_id FROM artists WHERE artist_name = 'Adele'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Master of Puppets', 1986, (SELECT artist_id FROM artists WHERE artist_name = 'Metallica'), (SELECT genre_id FROM genres WHERE genre_name = 'Metal')),
('Fearless', 2008, (SELECT artist_id FROM artists WHERE artist_name = 'Taylor Swift'), (SELECT genre_id FROM genres WHERE genre_name = 'Country')),
('Black Album', 1991, (SELECT artist_id FROM artists WHERE artist_name = 'Metallica'), (SELECT genre_id FROM genres WHERE genre_name = 'Metal')),
('Sgt. Pepper''s Lonely Hearts Club Band', 1967, (SELECT artist_id FROM artists WHERE artist_name = 'The Beatles'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('The Dark Side of the Moon', 1973, (SELECT artist_id FROM artists WHERE artist_name = 'Pink Floyd'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Kind of Blue', 1959, (SELECT artist_id FROM artists WHERE artist_name = 'Miles Davis'), (SELECT genre_id FROM genres WHERE genre_name = 'Jazz')),
('Thriller', 1982, (SELECT artist_id FROM artists WHERE artist_name = 'Michael Jackson'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Back in Black', 1980, (SELECT artist_id FROM artists WHERE artist_name = 'AC/DC'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Exile on Main St.', 1972, (SELECT artist_id FROM artists WHERE artist_name = 'The Rolling Stones'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('The Four Seasons', 1723, (SELECT artist_id FROM artists WHERE artist_name = 'Vivaldi'), (SELECT genre_id FROM genres WHERE genre_name = 'Classical')),
('To Pimp a Butterfly', 2015, (SELECT artist_id FROM artists WHERE artist_name = 'Kendrick Lamar'), (SELECT genre_id FROM genres WHERE genre_name = 'Hip Hop')),
('Come Away with Me', 2002, (SELECT artist_id FROM artists WHERE artist_name = 'Norah Jones'), (SELECT genre_id FROM genres WHERE genre_name = 'Jazz')),
('Purple Rain', 1984, (SELECT artist_id FROM artists WHERE artist_name = 'Prince'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Their Greatest Hits (1971–1975)', 1976, (SELECT artist_id FROM artists WHERE artist_name = 'Eagles'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Imagine', 1971, (SELECT artist_id FROM artists WHERE artist_name = 'John Lennon'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Nevermind', 1991, (SELECT artist_id FROM artists WHERE artist_name = 'Nirvana'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Highway 61 Revisited', 1965, (SELECT artist_id FROM artists WHERE artist_name = 'Bob Dylan'), (SELECT genre_id FROM genres WHERE genre_name = 'Folk-Rock')),
('Past Masters', 1988, (SELECT artist_id FROM artists WHERE artist_name = 'The Beatles'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
(NULL, 1997, (SELECT artist_id FROM artists WHERE artist_name = 'Daft Punk'), (SELECT genre_id FROM genres WHERE genre_name = 'Electronic')),
(NULL, 2020, (SELECT artist_id FROM artists WHERE artist_name = 'Taylor Swift'), (SELECT genre_id FROM genres WHERE genre_name = 'Folk-Rock')),
(NULL, 1971, (SELECT artist_id FROM artists WHERE artist_name = 'Jimi Hendrix'), (SELECT genre_id FROM genres WHERE genre_name = 'Blues')),
(NULL, 1969, (SELECT artist_id FROM artists WHERE artist_name = 'The Rolling Stones'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
(NULL, 1992, (SELECT artist_id FROM artists WHERE artist_name = 'Prince'), (SELECT genre_id FROM genres WHERE genre_name = 'R&B')),
(NULL, 2022, (SELECT artist_id FROM artists WHERE artist_name = 'Adele'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Rumours', 1977, (SELECT artist_id FROM artists WHERE artist_name = 'Eagles'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('DAMN.', 2017, (SELECT artist_id FROM artists WHERE artist_name = 'Kendrick Lamar'), (SELECT genre_id FROM genres WHERE genre_name = 'Hip Hop')),
('Born in the U.S.A.', 1984, (SELECT artist_id FROM artists WHERE artist_name = 'Bob Dylan'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Synchronicity', 1983, (SELECT artist_id FROM artists WHERE artist_name = 'The Beatles'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Sgt. Pepper''s...', 1967, (SELECT artist_id FROM artists WHERE artist_name = 'The Beatles'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Abbey Road', 1969, (SELECT artist_id FROM artists WHERE artist_name = 'The Beatles'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Let It Be', 1970, (SELECT artist_id FROM artists WHERE artist_name = 'The Beatles'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Lemonade', 2016, (SELECT artist_id FROM artists WHERE artist_name = 'Beyoncé'), (SELECT genre_id FROM genres WHERE genre_name = 'R&B')),
('Renaissance', 2022, (SELECT artist_id FROM artists WHERE artist_name = 'Beyoncé'), (SELECT genre_id FROM genres WHERE genre_name = 'House')),
('Thriller (40th Ed)', 2022, (SELECT artist_id FROM artists WHERE artist_name = 'Michael Jackson'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('In Utero', 1993, (SELECT artist_id FROM artists WHERE artist_name = 'Nirvana'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Nevermind (20th)', 2011, (SELECT artist_id FROM artists WHERE artist_name = 'Nirvana'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Sticky Fingers', 1971, (SELECT artist_id FROM artists WHERE artist_name = 'The Rolling Stones'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('The Rise and Fall of Ziggy Stardust...', 1972, (SELECT artist_id FROM artists WHERE artist_name = 'David Bowie'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Hunky Dory', 1971, (SELECT artist_id FROM artists WHERE artist_name = 'David Bowie'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('25', 2015, (SELECT artist_id FROM artists WHERE artist_name = 'Adele'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('÷ (Divide)', 2017, (SELECT artist_id FROM artists WHERE artist_name = 'Ed Sheeran'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Lover', 2019, (SELECT artist_id FROM artists WHERE artist_name = 'Taylor Swift'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Midnights', 2022, (SELECT artist_id FROM artists WHERE artist_name = 'Taylor Swift'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Scorpion', 2018, (SELECT artist_id FROM artists WHERE artist_name = 'Drake'), (SELECT genre_id FROM genres WHERE genre_name = 'Hip Hop')),
('Views', 2016, (SELECT artist_id FROM artists WHERE artist_name = 'Drake'), (SELECT genre_id FROM genres WHERE genre_name = 'Hip Hop')),
('When We All Fall Asleep, Where Do We Go?', 2019, (SELECT artist_id FROM artists WHERE artist_name = 'Billie Eilish'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Happier Than Ever', 2021, (SELECT artist_id FROM artists WHERE artist_name = 'Billie Eilish'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('The Fame', 2008, (SELECT artist_id FROM artists WHERE artist_name = 'Madonna'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Like a Prayer', 1989, (SELECT artist_id FROM artists WHERE artist_name = 'Madonna'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Damn The Torpedoes', 1979, (SELECT artist_id FROM artists WHERE artist_name = 'Eagles'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Ride The Lightning', 1984, (SELECT artist_id FROM artists WHERE artist_name = 'Metallica'), (SELECT genre_id FROM genres WHERE genre_name = 'Metal')),
('Appetite for Destruction', 1987, (SELECT artist_id FROM artists WHERE artist_name = 'Guns N Roses'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Chinese Democracy', 2008, (SELECT artist_id FROM artists WHERE artist_name = 'Guns N Roses'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('The Joshua Tree', 1987, (SELECT artist_id FROM artists WHERE artist_name = 'U2'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Achtung Baby', 1991, (SELECT artist_id FROM artists WHERE artist_name = 'U2'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('The Chronic', 1992, (SELECT artist_id FROM artists WHERE artist_name = 'Kendrick Lamar'), (SELECT genre_id FROM genres WHERE genre_name = 'Hip Hop')),
('Blue Train', 1957, (SELECT artist_id FROM artists WHERE artist_name = 'Miles Davis'), (SELECT genre_id FROM genres WHERE genre_name = 'Jazz')),
('Led Zeppelin II', 1969, (SELECT artist_id FROM artists WHERE artist_name = 'Led Zeppelin'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Led Zeppelin III', 1970, (SELECT artist_id FROM artists WHERE artist_name = 'Led Zeppelin'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Houses of the Holy', 1973, (SELECT artist_id FROM artists WHERE artist_name = 'Led Zeppelin'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Physical Graffiti', 1975, (SELECT artist_id FROM artists WHERE artist_name = 'Led Zeppelin'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Moving Pictures', 1981, (SELECT artist_id FROM artists WHERE artist_name = 'Rush'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('2112', 1976, (SELECT artist_id FROM artists WHERE artist_name = 'Rush'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Countdown to Extinction', 1992, (SELECT artist_id FROM artists WHERE artist_name = 'Metallica'), (SELECT genre_id FROM genres WHERE genre_name = 'Metal')),
('The Number of the Beast', 1982, (SELECT artist_id FROM artists WHERE artist_name = 'Iron Maiden'), (SELECT genre_id FROM genres WHERE genre_name = 'Metal')),
('Fear of the Dark', 1992, (SELECT artist_id FROM artists WHERE artist_name = 'Iron Maiden'), (SELECT genre_id FROM genres WHERE genre_name = 'Metal')),
('Out of Time', 1991, (SELECT artist_id FROM artists WHERE artist_name = 'R.E.M.'), (SELECT genre_id FROM genres WHERE genre_name = 'Folk-Rock')),
('Automatic for the People', 1992, (SELECT artist_id FROM artists WHERE artist_name = 'R.E.M.'), (SELECT genre_id FROM genres WHERE genre_name = 'Folk-Rock')),
('Blood Sugar Sex Magik', 1991, (SELECT artist_id FROM artists WHERE artist_name = 'Red Hot Chili Peppers'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Californication', 1999, (SELECT artist_id FROM artists WHERE artist_name = 'Red Hot Chili Peppers'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Definitely Maybe', 1994, (SELECT artist_id FROM artists WHERE artist_name = 'Oasis'), (SELECT genre_id FROM genres WHERE genre_name = 'Indie')),
('(What''s the Story) Morning Glory?', 1995, (SELECT artist_id FROM artists WHERE artist_name = 'Oasis'), (SELECT genre_id FROM genres WHERE genre_name = 'Indie')),
('Parklife', 1994, (SELECT artist_id FROM artists WHERE artist_name = 'Blur'), (SELECT genre_id FROM genres WHERE genre_name = 'Indie')),
('The Queen Is Dead', 1986, (SELECT artist_id FROM artists WHERE artist_name = 'The Smiths'), (SELECT genre_id FROM genres WHERE genre_name = 'Indie')),
('Violin Concerto in D Major', 1844, (SELECT artist_id FROM artists WHERE artist_name = 'Vivaldi'), (SELECT genre_id FROM genres WHERE genre_name = 'Classical')),
('Goldberg Variations', 1741, (SELECT artist_id FROM artists WHERE artist_name = 'J.S. Bach'), (SELECT genre_id FROM genres WHERE genre_name = 'Classical')),
('Nocturnes', 1846, (SELECT artist_id FROM artists WHERE artist_name = 'Chopin'), (SELECT genre_id FROM genres WHERE genre_name = 'Classical')),
('La bohème', 1896, (SELECT artist_id FROM artists WHERE artist_name = 'Puccini'), (SELECT genre_id FROM genres WHERE genre_name = 'Classical')),
('Ella and Louis', 1956, (SELECT artist_id FROM artists WHERE artist_name = 'Ella Fitzgerald'), (SELECT genre_id FROM genres WHERE genre_name = 'Jazz')),
('The Genius Sings the Blues', 1961, (SELECT artist_id FROM artists WHERE artist_name = 'Ray Charles'), (SELECT genre_id FROM genres WHERE genre_name = 'Blues')),
('I Never Loved a Man the Way I Love You', 1967, (SELECT artist_id FROM artists WHERE artist_name = 'Aretha Franklin'), (SELECT genre_id FROM genres WHERE genre_name = 'Soul')),
('Lana Del Rey', 2012, (SELECT artist_id FROM artists WHERE artist_name = 'SZA'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Stoney', 2016, (SELECT artist_id FROM artists WHERE artist_name = 'Post Malone'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Manic', 2020, (SELECT artist_id FROM artists WHERE artist_name = 'Halsey'), (SELECT genre_id FROM genres WHERE genre_name = 'Pop')),
('Watermark', 1988, (SELECT artist_id FROM artists WHERE artist_name = 'Enya'), (SELECT genre_id FROM genres WHERE genre_name = 'New Age')),
('Shepherd Moons', 1991, (SELECT artist_id FROM artists WHERE artist_name = 'Enya'), (SELECT genre_id FROM genres WHERE genre_name = 'New Age')),
('True', 2013, (SELECT artist_id FROM artists WHERE artist_name = 'Avicii'), (SELECT genre_id FROM genres WHERE genre_name = 'Electronic')),
('Evolve', 2017, (SELECT artist_id FROM artists WHERE artist_name = 'Imagine Dragons'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Parachutes', 2000, (SELECT artist_id FROM artists WHERE artist_name = 'Coldplay'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('A Rush of Blood to the Head', 2002, (SELECT artist_id FROM artists WHERE artist_name = 'Coldplay'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Unforgettable', 1991, (SELECT artist_id FROM artists WHERE artist_name = 'Nat King Cole'), (SELECT genre_id FROM genres WHERE genre_name = 'Jazz')),
('Blue Christmas', 1957, (SELECT artist_id FROM artists WHERE artist_name = 'Elvis Presley'), (SELECT genre_id FROM genres WHERE genre_name = 'Gospel')),
(NULL, 1994, (SELECT artist_id FROM artists WHERE artist_name = 'Wu-Tang Clan'), (SELECT genre_id FROM genres WHERE genre_name = 'Hip Hop')),
('Enter the Wu-Tang (36 Chambers)', 1993, (SELECT artist_id FROM artists WHERE artist_name = 'Wu-Tang Clan'), (SELECT genre_id FROM genres WHERE genre_name = 'Hip Hop')),
('Legend', 1984, (SELECT artist_id FROM artists WHERE artist_name = 'Bob Marley'), (SELECT genre_id FROM genres WHERE genre_name = 'Reggae')),
('Catch a Fire', 1973, (SELECT artist_id FROM artists WHERE artist_name = 'Bob Marley'), (SELECT genre_id FROM genres WHERE genre_name = 'Reggae')),
('Appetite for Destruction', 1987, (SELECT artist_id FROM artists WHERE artist_name = 'Led Zeppelin'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('The Wall', 1979, (SELECT artist_id FROM artists WHERE artist_name = 'Pink Floyd'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('News of the World', 1977, (SELECT artist_id FROM artists WHERE artist_name = 'Queen'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Queen I', 1973, (SELECT artist_id FROM artists WHERE artist_name = 'Queen'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Sheer Heart Attack', 1974, (SELECT artist_id FROM artists WHERE artist_name = 'Queen'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('A Night at the Opera', 1975, (SELECT artist_id FROM artists WHERE artist_name = 'Queen'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('A Day at the Races', 1976, (SELECT artist_id FROM artists WHERE artist_name = 'Queen'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('The Game', 1980, (SELECT artist_id FROM artists WHERE artist_name = 'Queen'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Flash Gordon', 1980, (SELECT artist_id FROM artists WHERE artist_name = 'Queen'), (SELECT genre_id FROM genres WHERE genre_name = 'Soundtrack')),
('Jazz', 1978, (SELECT artist_id FROM artists WHERE artist_name = 'Queen'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('Innuendo', 1991, (SELECT artist_id FROM artists WHERE artist_name = 'Queen'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock')),
('The Black Parade', 2006, (SELECT artist_id FROM artists WHERE artist_name = 'Queen'), (SELECT genre_id FROM genres WHERE genre_name = 'Rock'))
;

INSERT INTO tracks (track_title, duration_seconds, album_id) VALUES
('Bohemian Rhapsody', 354, (SELECT album_id FROM albums WHERE album_title = 'A Night at the Opera')),
('Stairway to Heaven', 482, (SELECT album_id FROM albums WHERE album_title = 'Led Zeppelin IV')),
('Rolling in the Deep', 221, (SELECT album_id FROM albums WHERE album_title = '21')),
('Master of Puppets', 515, (SELECT album_id FROM albums WHERE album_title = 'Master of Puppets')),
('You Belong With Me', 237, (SELECT album_id FROM albums WHERE album_title = 'Fearless')),
('We Will Rock You', 162, (SELECT album_id FROM albums WHERE album_title = 'News of the World')),
('Enter Sandman', 332, (SELECT album_id FROM albums WHERE album_title = 'Black Album')),
('The Unforgiven', 386, (SELECT album_id FROM albums WHERE album_title = 'Black Album')),
('Crazy Little Thing Called Love', 162, (SELECT album_id FROM albums WHERE album_title = 'News of the World')),
('Imagine', 192, (SELECT album_id FROM albums WHERE album_title = 'Imagine')),
('Smells Like Teen Spirit', 301, (SELECT album_id FROM albums WHERE album_title = 'Nevermind')),
('Like a Rolling Stone', 369, (SELECT album_id FROM albums WHERE album_title = 'Highway 61 Revisited')),
('Hey Jude', 431, (SELECT album_id FROM albums WHERE album_title = 'Past Masters')),
('Love of My Life', 217, (SELECT album_id FROM albums WHERE album_title = 'A Night at the Opera')),
('Black Dog', 294, (SELECT album_id FROM albums WHERE album_title = 'Led Zeppelin IV')),
('Someone Like You', 285, (SELECT album_id FROM albums WHERE album_title = '21')),
('Battery', 312, (SELECT album_id FROM albums WHERE album_title = 'Master of Puppets')),
('White Horse', 249, (SELECT album_id FROM albums WHERE album_title = 'Fearless'));

INSERT INTO playlists (playlist_name) VALUES
('Classic Rock Anthems'),
('Power Ballads'),
('90s Grunge'),
('Pop Hits 2011'),
('Thrash & Heavy Metal');


INSERT INTO playlist_tracks (playlist_id, track_id, track_order) VALUES
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Classic Rock Anthems'), (SELECT track_id FROM tracks WHERE track_title = 'Bohemian Rhapsody'), 1),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Classic Rock Anthems'), (SELECT track_id FROM tracks WHERE track_title = 'Stairway to Heaven'), 2),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Classic Rock Anthems'), (SELECT track_id FROM tracks WHERE track_title = 'We Will Rock You'), 3),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Pop Hits 2011'), (SELECT track_id FROM tracks WHERE track_title = 'Rolling in the Deep'), 1),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Pop Hits 2011'), (SELECT track_id FROM tracks WHERE track_title = 'Someone Like You'), 2),
((SELECT playlist_id FROM playlists WHERE playlist_name = '90s Grunge'), (SELECT track_id FROM tracks WHERE track_title = 'Smells Like Teen Spirit'), 1),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Power Ballads'), (SELECT track_id FROM tracks WHERE track_title = 'Bohemian Rhapsody'), 1),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Classic Rock Anthems'), (SELECT track_id FROM tracks WHERE track_title = 'Crazy Little Thing Called Love'), 4),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Classic Rock Anthems'), (SELECT track_id FROM tracks WHERE track_title = 'Black Dog'), 5),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Thrash & Heavy Metal'), (SELECT track_id FROM tracks WHERE track_title = 'Master of Puppets'), 1),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Thrash & Heavy Metal'), (SELECT track_id FROM tracks WHERE track_title = 'Enter Sandman'), 2),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Thrash & Heavy Metal'), (SELECT track_id FROM tracks WHERE track_title = 'Battery'), 3),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Thrash & Heavy Metal'), (SELECT track_id FROM tracks WHERE track_title = 'The Unforgiven'), 4),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Power Ballads'), (SELECT track_id FROM tracks WHERE track_title = 'Love of My Life'), 2),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Power Ballads'), (SELECT track_id FROM tracks WHERE track_title = 'Someone Like You'), 3),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Pop Hits 2011'), (SELECT track_id FROM tracks WHERE track_title = 'White Horse'), 3),
((SELECT playlist_id FROM playlists WHERE playlist_name = 'Classic Rock Anthems'), (SELECT track_id FROM tracks WHERE track_title = 'Imagine'), 6);


INSERT INTO company_branches (branch_name, city, established_date, parent_branch_id) VALUES
('Global Corporate HQ', 'London', '2000-01-01', NULL);

INSERT INTO company_branches (branch_name, city, established_date, parent_branch_id) VALUES
('Europe HQ', 'Paris', '2004-03-10', (SELECT branch_id FROM company_branches WHERE branch_name = 'Global Corporate HQ')),
('Asia HQ', 'Singapore', '2005-06-15', (SELECT branch_id FROM company_branches WHERE branch_name = 'Global Corporate HQ')),
('Americas HQ', 'New York', '2006-08-01', (SELECT branch_id FROM company_branches WHERE branch_name = 'Global Corporate HQ')),
('Africa HQ', 'Johannesburg', '2007-09-01', (SELECT branch_id FROM company_branches WHERE branch_name = 'Global Corporate HQ'));

INSERT INTO company_branches (branch_name, city, established_date, parent_branch_id) VALUES
('France National HQ', 'Marseille', '2010-01-15', (SELECT branch_id FROM company_branches WHERE branch_name = 'Europe HQ')),
('Japan National HQ', 'Tokyo', '2011-04-20', (SELECT branch_id FROM company_branches WHERE branch_name = 'Asia HQ')),
('Canada National HQ', 'Toronto', '2012-07-25', (SELECT branch_id FROM company_branches WHERE branch_name = 'Americas HQ')),
('Nigeria National HQ', 'Lagos', '2013-10-30', (SELECT branch_id FROM company_branches WHERE branch_name = 'Africa HQ'));

INSERT INTO company_branches (branch_name, city, established_date, parent_branch_id) VALUES
('Paris Office', 'Paris', '2015-02-01', (SELECT branch_id FROM company_branches WHERE branch_name = 'France National HQ')),
('Osaka Office', 'Osaka', '2016-05-06', (SELECT branch_id FROM company_branches WHERE branch_name = 'Japan National HQ')),
('Vancouver Office', 'Vancouver', '2017-08-11', (SELECT branch_id FROM company_branches WHERE branch_name = 'Canada National HQ')),
('Abuja Office', 'Abuja', '2018-11-16', (SELECT branch_id FROM company_branches WHERE branch_name = 'Nigeria National HQ'));

INSERT INTO company_branches (branch_name, city, established_date, parent_branch_id) VALUES
('Paris Retail Store A', 'Paris', '2020-03-20', (SELECT branch_id FROM company_branches WHERE branch_name = 'Paris Office')),
('Osaka Retail Store B', 'Osaka', '2021-06-25', (SELECT branch_id FROM company_branches WHERE branch_name = 'Osaka Office')),
('Vancouver Retail Store C', 'Vancouver', '2022-09-30', (SELECT branch_id FROM company_branches WHERE branch_name = 'Vancouver Office')),
('Paris Retail Store D', 'Paris', '2023-01-10', (SELECT branch_id FROM company_branches WHERE branch_name = 'Paris Office')),
('Paris Retail Store E', 'Paris', '2023-04-15', (SELECT branch_id FROM company_branches WHERE branch_name = 'Paris Office')),
('Osaka Retail Store F', 'Osaka', '2023-07-20', (SELECT branch_id FROM company_branches WHERE branch_name = 'Osaka Office')),
('Vancouver Retail Store G', 'Vancouver', '2023-10-25', (SELECT branch_id FROM company_branches WHERE branch_name = 'Vancouver Office')),
('Abuja Retail Store H', 'Abuja', '2024-01-30', (SELECT branch_id FROM company_branches WHERE branch_name = 'Abuja Office'));


-- Additional population of Tables for the indexing strategies in 5_indexes
WITH existing_albums AS (
    SELECT
        album_id,
        COALESCE(album_title, 'Untitled Album') AS safe_album_title -- TODO :: Technical Fix: Replaces NULL album_title
    FROM
        albums
    WHERE
        album_id IS NOT NULL
),
track_count AS (
    SELECT
        a.album_id,
        a.safe_album_title,
        FLOOR(RANDOM() * 11 + 5)::INT AS num_tracks
    FROM existing_albums a
),
generated_tracks AS (
    SELECT
        tc.album_id,
        'Track ' || s.i || ' (' || tc.safe_album_title || ')' AS track_title,
        FLOOR(RANDOM() * 481 + 120)::INT AS duration_seconds
    FROM
        track_count tc
    CROSS JOIN LATERAL
        generate_series(1, tc.num_tracks) AS s(i)
)
INSERT INTO tracks (track_title, duration_seconds, album_id)
SELECT
    track_title,
    duration_seconds,
    album_id
FROM
    generated_tracks;


-- Table population for use in regards to 5_Indezes
WITH id_ranges AS (
    SELECT
        MIN(a.album_id) AS min_a,
        MAX(a.album_id) AS max_a,
        MIN(r.artist_id) AS min_r,
        MAX(r.artist_id) AS max_r
    FROM
        albums a
    CROSS JOIN
        artists r
)
INSERT INTO purchases (album_id, artist_id, amount)
SELECT
    FLOOR(RANDOM() * (r.max_a - r.min_a + 1) + r.min_a)::INT,
    FLOOR(RANDOM() * (r.max_r - r.min_r + 1) + r.min_r)::INT,
    (RANDOM() * 15.00 + 5.00)::NUMERIC(10, 2)
FROM
    generate_series(1, 1000000) AS s(i)
CROSS JOIN
    id_ranges r;




WITH artist_range AS (
    SELECT
        MIN(artist_id) AS min_r,
        MAX(artist_id) AS max_r
    FROM
        artists
)
INSERT INTO concerts (artist_id, venue_name, schedule)
SELECT
    FLOOR(RANDOM() * (r.max_r - r.min_r + 1) + r.min_r)::INT,
    'Venue_' || (s.i % 50 + 1),
    tsrange(
        random_start.start_time,
        random_start.start_time + ('1 hour'::interval * RANDOM() + '1 hour'::interval)
    )
FROM
    generate_series(1, 10000) AS s(i)
CROSS JOIN
    artist_range r
CROSS JOIN LATERAL (
    SELECT '2025-01-01'::timestamp + (s.i * '1 day'::interval * RANDOM()) AS start_time
) AS random_start;





WITH valid_artists AS (
    SELECT artist_id
    FROM artists
    WHERE artist_name IS NOT NULL
),
random_collaborations AS (
    SELECT
        FLOOR(RANDOM() * 1000) + 1 AS collaboration_group_id,
        va.artist_id
    FROM
        valid_artists va
    CROSS JOIN
        generate_series(1, 10000) AS s(i)
    WHERE RANDOM() < 0.2
),
grouped_collaborations AS (
    SELECT
        collaboration_group_id,
        ARRAY_AGG(DISTINCT artist_id) AS collaborator_ids,
        COUNT(DISTINCT artist_id) AS artist_count
    FROM
        random_collaborations
    GROUP BY
        collaboration_group_id
    HAVING COUNT(DISTINCT artist_id) >= 2
)
INSERT INTO collaborations (album_id, collaborator_ids)
SELECT
    (SELECT album_id FROM albums ORDER BY RANDOM() LIMIT 1),
    gc.collaborator_ids
FROM
    grouped_collaborations gc;



INSERT INTO publishers (name, country, established_year)
SELECT
    'Publisher ' || g,
    CASE floor(random() * 3)
        WHEN 0 THEN 'USA'
        WHEN 1 THEN 'EU'
        ELSE 'CH'
    END,
    (random() * 50 + 1950)::int
FROM generate_series(1, 250000) g;

