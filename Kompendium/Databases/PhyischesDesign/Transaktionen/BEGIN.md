**`Begin`** startet eine Transaction (Synonym zu **`START TRANSACTION`**)

```sql
BEGIN;
UPDATE konten SET saldo = saldo - 50 WHERE id = 1;
```
Ab hier sind alle folgenden Befehle Teil der Transaktion, bis **`COMMIT`** oder **`ROLLBACK`** kommt.