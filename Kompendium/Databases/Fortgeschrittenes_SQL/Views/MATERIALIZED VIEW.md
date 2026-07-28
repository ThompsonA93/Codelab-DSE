
Im Vergleich zum Normalen View speichert ein Materialized View das Ergebnis physisch auf der Festplatte.
- Die Daten werden zum Zeitpunkt der Erstellung berechnet und dauerhaft abgelegt
- nach dem ersten Aufbau sind Lesezugriffe sehr schnell. da keine erneuter Berechnung nötig ist
- Wird häufig für Data Warehousing, Reporting oder Aggregierte Kennzahlen (z.B. Summen, Durchschnittswerte) verwendet, wenn die Basisdaten sich selten ändern oder Performance wichtiger ist als Aktualität

```sql
CREATE MATERUALIZED VIEW LabView AS
SELECT * FROM BfiLab;

SELECT * From LabView

```