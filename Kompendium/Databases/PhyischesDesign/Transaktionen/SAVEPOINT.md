Setzt einen "Zwischenpunkt" innerhalb einer Transaktion, zu dem man gezielt zurückrollen kann, ohne die ganze Transaktion abzubrechen.

```sql
BEGIN;
UPDATE konten SET saldo = saldo - 50 WHERE id = 1;
SAVEPOINT vor_zweiter_buchung;

UPDATE konten SET saldo = saldo + 50 WHERE id = 999; -- Konto existiert nicht / Fehler
ROLLBACK TO SAVEPOINT vor_zweiter_buchung;  -- nur diesen Teil rückgängig machen

UPDATE konten SET saldo = saldo + 50 WHERE id = 2;  -- korrigierte Buchung
COMMIT;
```

Am ähnlichsten zu vergleichen, mit der C# Funktion `Try-Catch` bzw. mit verschachtelten `Try-Catchs`.

**`C#`:**
```csharp
try {
    KontoAbbuchen(1, 50);       // Schritt 1
    try {
        KontoGutschreiben(999, 50); // Schritt 2 – schlägt fehl
    } catch {
        // nur Schritt 2 rückgängig machen, Schritt 1 bleibt bestehen
    }
    KontoGutschreiben(2, 50);   // Schritt 3 – Korrektur
} catch {
    // alles rückgängig machen
}
```

**`SQL`:**
```SQL
BEGIN;
UPDATE konten SET saldo = saldo - 50 WHERE id = 1;      -- Schritt 1
SAVEPOINT nach_schritt1;
UPDATE konten SET saldo = saldo + 50 WHERE id = 999;    -- Schritt 2 – Fehler
ROLLBACK TO SAVEPOINT nach_schritt1;                     -- nur Schritt 2 zurück
UPDATE konten SET saldo = saldo + 50 WHERE id = 2;      -- Schritt 3 – Korrektur
COMMIT;
```

