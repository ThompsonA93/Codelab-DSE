CHECK prüft fachliche Regeln über logische Ausdrücke. Die Zeile wird nur abgelehnt, wenn der Ausdruck explizit `FALSE` ergibt.

## Syntax

```sql
CREATE TABLE products (
    name     text    NOT NULL,
    price    numeric CHECK (price > 0),           -- Spalten-Level
    discount numeric,
    CHECK (discount IS NULL OR discount < price)  -- Tabellen-Level (mehrere Spalten)
);
```

| Form | Wann |
|------|------|
| `price numeric CHECK (...)` | Regel betrifft eine Spalte |
| `CHECK (...)` am Tabellenende | Regel vergleicht mehrere Spalten |

## Verhalten

```sql
INSERT INTO products (name, price) VALUES ('Tee', 3.50);   -- ok
INSERT INTO products (name, price) VALUES ('Kaffee', -1); -- Fehler: price > 0
INSERT INTO products (name, price, discount)
    VALUES ('Milch', 2.00, 2.50);                         -- Fehler: discount < price
```

## NULL in CHECK

`NULL` gilt als **gültig**. Schlägt nur fehl bei explizitem `FALSE`.

```sql
-- price ist NULL → Ausdruck price > 0 ergibt NULL → erlaubt
INSERT INTO products (name, price) VALUES ('Probe', NULL);
```

Deshalb oft mit [[NOT NULL]] kombinieren, wenn die Spalte Pflicht ist:

```sql
price numeric NOT NULL CHECK (price > 0)
```

## Typische Regeln

```sql
-- Wertebereich
age integer CHECK (age BETWEEN 0 AND 150)

-- erlaubte Werte
status text CHECK (status IN ('offen', 'bezahlt', 'storniert'))

-- Abhängigkeit zwischen Spalten
CHECK (end_date >= start_date)
```

## Nachträglich setzen

```sql
ALTER TABLE products
    ADD CONSTRAINT products_price_positive CHECK (price > 0);
```

## Achtung

CHECK gilt pro Zeile. Regeln über mehrere Zeilen (z. B. „Summe darf X nicht überschreiten“) brauchen Trigger oder andere Mechanismen.

Ausdrücke in CHECK sollten stabil und deterministisch sein — keine volatilen Funktionen wie `now()` als alleinige Geschäftsregel, wenn sich die Gültigkeit mit der Zeit ändern soll.

## Quellen

- PostgreSQL Doku, Check Constraints: https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-CHECK-CONSTRAINTS
- PostgreSQL Doku, CREATE TABLE: https://www.postgresql.org/docs/current/sql-createtable.html
