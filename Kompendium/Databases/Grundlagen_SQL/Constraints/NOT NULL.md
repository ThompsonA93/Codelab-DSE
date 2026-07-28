NOT NULL verhindert leere Einträge. Die Spalte muss beim Einfügen und Aktualisieren einen Wert haben — `NULL` ist nicht erlaubt.

## Syntax

```sql
CREATE TABLE users (
    id       integer NOT NULL,  -- Pflichtfeld
    username text    NOT NULL,  -- Pflichtfeld
    bio      text               -- optional, darf NULL sein
);
```

Spalten-Level: `NOT NULL` steht direkt bei der Spaltendefinition.

## Verhalten

```sql
INSERT INTO users (id, username) VALUES (1, 'anna');
-- ok: bio bleibt NULL

INSERT INTO users (id, bio) VALUES (2, 'Hallo');
-- Fehler: username ist NOT NULL
```

| Situation | Ergebnis |
|-----------|----------|
| Wert angegeben | ok |
| Spalte weggelassen / explizit `NULL` | Fehler |
| Spalte ohne `NOT NULL` | `NULL` erlaubt |

## Nachträglich setzen

```sql
ALTER TABLE users
    ALTER COLUMN bio SET NOT NULL;
```

Geht nur, wenn in der Spalte aktuell kein `NULL` steht. Sonst zuerst die vorhandenen Nullen befüllen.

```sql
ALTER TABLE users
    ALTER COLUMN bio DROP NOT NULL;
```

## Achtung

`NOT NULL` und `UNIQUE` sind unabhängig. Eine Spalte kann beides haben — dann ist sie Pflicht und eindeutig (ähnlich einem Primärschlüssel, aber ohne die PK-Semantik).

Leere Strings (`''`) sind nicht `NULL`. `NOT NULL` blockiert nur echte Nullwerte.

## Quellen

- PostgreSQL Doku, CREATE TABLE: https://www.postgresql.org/docs/current/sql-createtable.html
- PostgreSQL Doku, ALTER TABLE: https://www.postgresql.org/docs/current/sql-altertable.html
