UNIQUE garantiert Eindeutigkeit — kein Wert darf doppelt vorkommen. PostgreSQL legt dafür automatisch einen B-Tree-Index an.

## Syntax

```sql
CREATE TABLE accounts (
    id         integer,
    email      text UNIQUE,              -- Spalten-Level: jede E-Mail nur 1×
    first_name text,
    last_name  text,
    UNIQUE (first_name, last_name)       -- Tabellen-Level: Kombination eindeutig
);
```

| Form | Bedeutung |
|------|-----------|
| `email text UNIQUE` | einzelne Spalte eindeutig |
| `UNIQUE (a, b)` | Kombination von Spalten eindeutig |

## Verhalten

```sql
INSERT INTO accounts (id, email) VALUES (1, 'a@x.de');  -- ok
INSERT INTO accounts (id, email) VALUES (2, 'a@x.de');  -- Fehler: Duplikat
```

Bei zusammengesetztem UNIQUE zählt die gesamte Kombination:

```sql
INSERT INTO accounts (id, first_name, last_name) VALUES (1, 'Max', 'Müller');  -- ok
INSERT INTO accounts (id, first_name, last_name) VALUES (2, 'Max', 'Schmidt'); -- ok
INSERT INTO accounts (id, first_name, last_name) VALUES (3, 'Max', 'Müller');  -- Fehler
```

## NULL und UNIQUE

Standardmäßig sind **mehrere** `NULL`-Werte erlaubt, weil in SQL `NULL != NULL` gilt. Jede Zeile mit `NULL` gilt als „anders“ als die nächste.

```sql
INSERT INTO accounts (id, email) VALUES (1, NULL);  -- ok
INSERT INTO accounts (id, email) VALUES (2, NULL);  -- ok (mehrere NULLs)
```

Soll höchstens ein `NULL` erlaubt sein, braucht man einen partiellen Index:

```sql
CREATE UNIQUE INDEX accounts_email_null_unique
    ON accounts (email)
    WHERE email IS NULL;
```

Oder die Spalte zusätzlich mit [[NOT NULL]] absichern, wenn `NULL` fachlich ohnehin keinen Sinn ergibt.

## Nachträglich setzen

```sql
ALTER TABLE accounts
    ADD CONSTRAINT accounts_email_unique UNIQUE (email);
```

## Achtung

`UNIQUE` erzeugt einen Index — Abfragen über die Spalte profitieren davon, Schreibvorgänge werden etwas teurer.

Groß-/Kleinschreibung zählt: `'A@x.de'` und `'a@x.de'` sind zwei verschiedene Werte. Für case-insensitive Eindeutigkeit z. B. `UNIQUE` auf `LOWER(email)` über einen Ausdrucksindex.

## Quellen

- PostgreSQL Doku, Unique Constraints: https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-UNIQUE-CONSTRAINTS
- PostgreSQL Doku, CREATE INDEX: https://www.postgresql.org/docs/current/sql-createindex.html
