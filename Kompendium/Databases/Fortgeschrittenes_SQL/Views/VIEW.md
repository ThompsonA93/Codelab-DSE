Ein View ist das Ergebnis einer gespeicherten Query welche dem Benutzer eine eingeschränkte Perspektive auf die zugrunde liegenden Tabellen bietet.

- Ein View speichert keine eigenen Daten
- Bei jedem Zugriff auf den View wird die zugrunde liegende Query zur Laufzeit neu ausgeführt - die Daten sind also immer aktuell
- Views sind nicht Teil des physischen Schemas (belegt keinen Speicherplatz für die Daten)

### Vorteile
- Vereinfachung komplexer Abfragen
- Datenschutz / Zugriffskontrolle
- Logische Datenunabhängigkeit

### Beispiele
```sql
CREATE VIEW LabView AS 
SELECT * FROM BfiLab;

Select * FROM LabView;
```

```sql
CREATE VIEW AktiveLabTests AS
SELECT patient_id, test_name, ergebnis, datum
FROM BfiLab
Where status = 'aktiv'

SELECT * FROM AktiveLabTests WHERE patient_id = 213;
```