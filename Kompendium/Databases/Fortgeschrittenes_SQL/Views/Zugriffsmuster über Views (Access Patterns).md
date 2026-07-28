Views werden in der Praxis für verschiedene Zugriffsmuster genutzt:
1. **Sicherheits-/ Berechtigungsmuster**
   Benutzer erhalten Zugriff nur auf den View, nicht auf die Basistabelle - so lassen sich sensible Spalten (z.b. Patientendaten) ausblenden
   
```sql
   CREATE VIEW OeffentlicheLabDaten AS
   SELECT test_name, ergebnis, datum
   FROM BfiLab
```
2. **Abstraktions- / Vereinfachungsmuster**
   Komplexe Joins über mehrere Tabellen werden im View gekapselt, sodass Endanwender einfache SELECT-Abfragen schreiben können.
   
```sql
   CREATE VIEW PatientMitLabdaten AS
   SELECT p.name, p.geburtsdatum, l.test_name, l.ergebnis
   FROM Patient p
   JOIN BfiLab l ON p.patient_id = l.patient_id;
```

3. **Aggregations-/ Reporting-Muster**
   Häufig in Kombination mit Materialized Views für Dashboards/ Reports genutzt, um wiederkehrende Aggregationen nicht ständig neu berechnen zu müssen

4. **Logische Datenunabhängigkeit**
   Wenn sich das physische Schema ändert, kann der View so angepasst werden, dass Anwendungen, die auf den View zugreifen, unverändert weiterlaufen

5. **Horizontale/ Vertikale Partitionierung**
   View können nur bestimmte Zeilen oder Spalten eines Datensatzes zeigen.