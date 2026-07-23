LAG holt den Wert aus der Zeile davor in die aktuelle Zeile.

Wie beim Stromzähler. Der Stand allein sagt nichts, erst dieser Monat minus letzter Monat zeigt den Verbrauch.

## Syntax

```sql
LAG(umsatz) OVER (PARTITION BY region ORDER BY monat)
```

```
Zeilen:   Jan     Feb     Maer
                   ^ aktuelle Zeile
LAG      <--+          holt den Januar-Wert in die Februar-Zeile
```

ORDER BY ist Pflicht. Ohne Reihenfolge gibt es kein davor.

## Beispiel

```sql
SELECT region, monat, umsatz,
       LAG(umsatz) OVER (PARTITION BY region ORDER BY monat) AS vormonat,
       umsatz - LAG(umsatz) OVER (PARTITION BY region ORDER BY monat) AS differenz
FROM verkaeufe;
```

| region | monat | umsatz | vormonat | differenz |
|--------|-------|--------|----------|-----------|
| Nord | 2026-01 | 100 | NULL | NULL |
| Nord | 2026-02 | 120 | 100  | +20  |
| Nord | 2026-03 | 90  | 120  | -30  |
| Sued | 2026-01 | 200 | NULL | NULL |
| Sued | 2026-02 | 150 | 200  | -50  |
| Sued | 2026-03 | 250 | 150  | +100 |

Zwei Dinge fallen auf. Der Januar bekommt NULL, weil er keinen Vormonat hat. Und Sued Januar bekommt nicht den Maerz-Wert von Nord, weil LAG die Gruppengrenze nicht überschreitet.

## Weitere Argumente

```sql
LAG(umsatz, 1, 0) OVER (...)   -- statt NULL kommt 0
LAG(umsatz, 2)    OVER (...)   -- zwei Zeilen zurueck
```

Überleg dir das mit der 0 gut. Kein Vormonat und ein Vormonat mit 0 Umsatz sind zwei verschiedene Dinge.

## Wofür du es brauchst

```sql
-- gefallen oder gestiegen
CASE WHEN umsatz < LAG(umsatz) OVER w THEN 'gefallen' ELSE 'gestiegen' END

-- Zeit zwischen zwei Ereignissen
zeitpunkt - LAG(zeitpunkt) OVER (PARTITION BY benutzer ORDER BY zeitpunkt)
```

## Achtung

Der Offset zählt Zeilen, nicht Monate. Fehlt ein Monat in den Daten, nimmt LAG trotzdem die vorige vorhandene Zeile.

Bei Prozentrechnungen mit `NULLIF(LAG(...), 0)` gegen Division durch null absichern.

## Quellen

- MySQL 8.0 Manual, Window Function Descriptions: https://dev.mysql.com/doc/refman/8.0/en/window-function-descriptions.html
- PostgreSQL 18 Doku, 9.22 Window Functions: https://www.postgresql.org/docs/current/functions-window.html
