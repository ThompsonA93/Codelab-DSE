
> https://www.postgresql.org/

PostgreSQL ist ein leistungsstarkes, quelloffenes objektrelationales Datenbanksystem, das seit über 35 Jahren aktiv weiterentwickelt wird und sich einen hervorragenden Ruf hinsichtlich Zuverlässigkeit, Robustheit der Funktionen und Leistung erworben hat.

## Installation

Postgres lässt sich auf mehrere Arten nutzen.

1. Installation der Datenbank [[PostgreSQL]] nativ auf dem Host
2. Aufsetzen der Datenbank über [[Docker]]-Container

## Nutzung

Um Postgres zu nutzen, bedarf es einem Tool was das Protokol PostgreSQL-Wire-Protokoll richtig implementiert.

- libpq: Offizielle C-Bibliothek welche von [[pgAdmin]] und [[PSQL-CLI]] implementiert werden.
- JDBC-Treiber: Java Database Connectivity-Treiber, üblich für Applikationen wie [[Datagrip]] oder [[DBeaver]]
