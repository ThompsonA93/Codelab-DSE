#### `ROLLBACK`

Macht alle Änderungen seit `BEGIN` rückgängig.

```SQL
BEGIN;
UPDATE konten SET saldo = saldo - 50 WHERE id = 1;
-- Fehler: Konto hätte dadurch negativen Saldo
ROLLBACK;  -- Update wird verworfen, saldo bleibt wie vorher
```
#### `ROLLBACK TO SAVEPOINT`

Macht alle Änderungen bis zu einem bestimmten **`[[SAVEPOINT]]`** rückgängig.

```SQL
BEGIN;
UPDATE konten SET saldo = saldo - 50 WHERE id = 1;      -- Schritt 1
SAVEPOINT nach_schritt1;
UPDATE konten SET saldo = saldo + 50 WHERE id = 999;    -- Schritt 2 – Fehler
ROLLBACK TO SAVEPOINT nach_schritt1;                     -- nur Schritt 2 zurück
UPDATE konten SET saldo = saldo + 50 WHERE id = 2;      -- Schritt 3 – Korrektur
COMMIT;
```

