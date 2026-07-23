PARTITION BY teilt die Zeilen in Gruppen. Die Funktion beginnt bei jeder Gruppe neu. Alle Zeilen bleiben stehen.

Es gruppiert, ohne zu vernichten. Das ist der Unterschied zu GROUP BY.

## Syntax

```sql
SUM(umsatz) OVER (PARTITION BY region)
```

Steht immer innerhalb der OVER-Klammer, immer vor ORDER BY.

## Beispiel

```sql
SELECT region, monat, umsatz,
       SUM(umsatz) OVER (PARTITION BY region) AS region_summe
FROM verkaeufe;
```

| region | monat | umsatz | region_summe |
|--------|-------|--------|--------------|
| Nord | 2026-01 | 100 | 310 |
| Nord | 2026-02 | 120 | 310 |
| Nord | 2026-03 | 90  | 310 |
| Sued | 2026-01 | 200 | 600 |
| Sued | 2026-02 | 150 | 600 |
| Sued | 2026-03 | 250 | 600 |

```
alle Zeilen
     |  PARTITION BY region
     v
+--------------+   +--------------+
| Nord         |   | Sued         |
| 100 120  90  |   | 200 150 250  |
| Summe 310    |   | Summe 600    |
+--------------+   +--------------+
```

## Wofür du es brauchst

Jede Zeile kennt ihre Gruppensumme, also ist ein Prozentwert eine Zeile Code.

```sql
SELECT region, monat, umsatz,
       ROUND(100.0 * umsatz / SUM(umsatz) OVER (PARTITION BY region), 1) AS anteil_pct
FROM verkaeufe;
```

Nord Januar: 100 / 310 = 32,3 Prozent.

## GROUP BY gegen PARTITION BY

| | GROUP BY | PARTITION BY |
|---|----------|--------------|
| Ergebniszeilen | eine pro Gruppe | alle |
| Detailspalten | nur gruppierte | alle erlaubt |
| Mehrere Gruppierungen gleichzeitig | nein | ja |

## Achtung

Ohne PARTITION BY sind alle Zeilen eine einzige Gruppe.

Die Gruppe ist eine Wand. LAG, laufende Summen und Ranglisten springen nie in die Nachbargruppe.

Anteil am Gesamtumsatz braucht `OVER ()`, nicht `OVER (PARTITION BY region)`. Frag dich immer: Anteil woran?

## Quellen

- PostgreSQL 18 Doku, 3.5 Window Functions: https://www.postgresql.org/docs/current/tutorial-window.html
- Microsoft Learn, OVER Clause: https://learn.microsoft.com/en-us/sql/t-sql/queries/select-over-clause-transact-sql
