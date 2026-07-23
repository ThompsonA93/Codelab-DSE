LEAD holt den Wert aus der Zeile danach. Gleiche Funktion wie LAG, andere Richtung.

Merkhilfe: lag heißt hinterherhinken, lead heißt vorangehen.

## Syntax

```sql
LEAD(umsatz) OVER (PARTITION BY region ORDER BY monat)
```

```
Zeilen:   Jan     Feb     Maer
                   ^ aktuelle Zeile
LEAD               +-->   holt den Maerz-Wert
LAG          <--+         holt den Januar-Wert
```

## Beispiel

```sql
SELECT region, monat, umsatz,
       LEAD(umsatz) OVER (PARTITION BY region ORDER BY monat) AS folgemonat
FROM verkaeufe;
```

| region | monat | umsatz | folgemonat |
|--------|-------|--------|-----------|
| Nord | 2026-01 | 100 | 120  |
| Nord | 2026-02 | 120 | 90   |
| Nord | 2026-03 | 90  | NULL |
| Sued | 2026-01 | 200 | 150  |
| Sued | 2026-02 | 150 | 250  |
| Sued | 2026-03 | 250 | NULL |

Bei LEAD steht NULL unten. Der letzte Monat hat keinen Nachfolger.

## LAG oder LEAD

Beide liefern dieselben Differenzen, nur um eine Zeile verschoben.

| monat | umsatz | mit LAG | mit LEAD |
|-------|--------|---------|----------|
| 2026-01 | 100 | NULL | +20  |
| 2026-02 | 120 | +20  | -30  |
| 2026-03 | 90  | -30  | NULL |

Entscheide danach, wo die Zahl stehen soll. Ein Bericht über den Vormonat nimmt LAG, eine Vorschau nimmt LEAD.

## Wofür du es brauchst

```sql
-- Wartezeit bis zum naechsten Ereignis
LEAD(zeitpunkt) OVER (PARTITION BY benutzer ORDER BY zeitpunkt) - zeitpunkt

-- ist das die letzte Zeile der Gruppe?
CASE WHEN LEAD(id) OVER w IS NULL THEN 'letzte' END
```

## Achtung

NULL trifft bei LEAD das Ende der Gruppe, bei LAG den Anfang.

Das dritte Argument setzt einen Ersatzwert: `LEAD(umsatz, 1, 0)`.

## Quellen

- MySQL 8.0 Manual, Window Function Descriptions: https://dev.mysql.com/doc/refman/8.0/en/window-function-descriptions.html
- PostgreSQL 18 Doku, 9.22 Window Functions: https://www.postgresql.org/docs/current/functions-window.html
