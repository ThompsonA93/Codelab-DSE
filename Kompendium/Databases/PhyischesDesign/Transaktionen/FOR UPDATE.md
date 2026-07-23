Sperrt die gelesenen Zeilen für andere Transaktionen (Zeilensperre), bis die eigene Transaktion beendet ist. Verhindert, dass zwei Transaktionen gleichzeitig dieselbe Zeile ändern.

```SQL
BEGIN;
SELECT saldo FROM konten WHERE id = 1 FOR UPDATE;
-- Andere Transaktionen müssen jetzt warten, wenn sie Zeile id=1 auch sperren wollen
UPDATE konten SET saldo = saldo - 50 WHERE id = 1;
COMMIT;
```
Typischer Anwendungsfall: Verhindert, dass zwei parallele Überweisungen denselben (veralteten) Saldo lesen und beide darauf basierend rechnen.