Wird zusammen mit `FOR UPDATE` genutzt: Bereits gesperrte Zeilen werden einfach übersprungen, statt dass die Abfrage wartet. Nützlich z.B. bei Job-Queues, wo mehrere Worker parallel Aufgaben abholen sollen, ohne sich gegenseitig zu blockieren.

```sql
BEGIN;
SELECT * FROM job_queue
WHERE status = 'pending'
ORDER BY id
LIMIT 1
FOR UPDATE SKIP LOCKED;
-- holt den nächsten freien Job, überspringt Zeilen, die andere Worker gerade bearbeiten
```