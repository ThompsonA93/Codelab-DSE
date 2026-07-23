### Anomalien bei parallelen Transaktionen
---
Diese treten auf, wenn mehrere Transaktionen gleichzeitig laufen und der Isolation Level nicht streng genug ist.
##### **Dirty Read**
---
Eine Transaktion liest Daten, die eine andere Transaktion geändert, aber noch nicht committet hat. Wird das Original zurückgerollt, hat man mit "Geisterdaten" gearbeitet.

```sql
-- Transaktion A:
BEGIN;
UPDATE konten SET saldo = 1000 WHERE id = 1;
-- (noch kein COMMIT)

-- Transaktion B (bei READ UNCOMMITTED):
SELECT saldo FROM konten WHERE id = 1;  -- liest 1000, obwohl nicht committet

-- Transaktion A:
ROLLBACK;  -- saldo ist wieder der alte Wert – B hatte falsche Daten gelesen
```
##### **Non-repeatable Read**

Eine Transaktion liest dieselbe Zeile zweimal und bekommt unterschiedliche Werte, weil eine andere Transaktion dazwischen committet hat.

```sql
-- Transaktion A:
BEGIN;
SELECT saldo FROM konten WHERE id = 1;  -- liest z.B. 500

-- Transaktion B:
BEGIN;
UPDATE konten SET saldo = 300 WHERE id = 1;
COMMIT;

-- Transaktion A (gleiche Transaktion, zweites SELECT):
SELECT saldo FROM konten WHERE id = 1;  -- liest jetzt 300 – anderer Wert!
COMMIT;
```
##### **Phantom Read**

Ähnlich wie Non-repeatable Read, aber bezogen auf eine ganze Ergebnismenge: Eine Transaktion führt dieselbe Abfrage zweimal aus und bekommt unterschiedlich viele Zeilen, weil eine andere Transaktion neue Zeilen eingefügt (oder gelöscht) hat.

```sql
-- Transaktion A:
BEGIN;
SELECT COUNT(*) FROM konten WHERE saldo > 100;  -- ergibt z.B. 5

-- Transaktion B:
BEGIN;
INSERT INTO konten (id, saldo) VALUES (50, 200);
COMMIT;

-- Transaktion A (gleiche Transaktion, gleiche Abfrage):
SELECT COUNT(*) FROM konten WHERE saldo > 100;  -- ergibt jetzt 6 – "Phantom"-Zeile
COMMIT;
```

**Zusammenhang mit Isolation Levels:** `READ UNCOMMITTED` erlaubt alle drei Anomalien, `READ COMMITTED` verhindert `Dirty Reads`, `REPEATABLE READ` (MariaDB-Standard) verhindert zusätzlich Non-repeatable Reads, und `SERIALIZABLE` verhindert alle drei – kostet aber am meisten Performance.