Ein kann unter Bestimmten Bedingungen auch für INSERT, UPDATE und DELETE verwendet werden - in diesem fall spricht man von einem Updateable view.

#### Voraussetzungen damit ein View aktualisierbar ist:

- Der View basiert auf genau einer Basistabelle
- Keine Verwendung von GROUP_BY, DISTINCT, HAVING, Aggregatfunktionen
- Alle Pflichtfelder der Basistabelle müssen im View enthalten sein, damit ein INSERT gültig ist
- KEIN UNION, INTERSECT, EXCEPT


```sql
CREATE VIEW LabViewUpdate AS
SELECT lab_id, patient_id, test_name, ergebnis
FROM BfiLab
WHERE status = 'aktiv';

-- Aktualisierung über den View
UPDATE LabViewUpdate
SET ergebnis = 5.6
WHERE lab_id = 100;

-- Einfügen über den View
INSERT INTO LabViewUpdate (lab_id, patient_id, test_name, ergebnis)
VALUES (200, 4712, 'Blutzucker', 5.2);
```