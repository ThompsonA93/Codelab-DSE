Schreibt alle Änderungen der Transaktion dauerhaft in die DB.

```SQL
BEGIN; 
UPDATE konten SET saldo = saldo - 50 WHERE id = 1; 
UPDATE konten SET saldo = saldo + 50 WHERE id = 2; 
COMMIT; -- beide Updates sind jetzt endgültig
```