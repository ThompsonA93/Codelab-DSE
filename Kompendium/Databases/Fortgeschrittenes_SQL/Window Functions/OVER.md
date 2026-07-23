OVER macht aus einer normalen Funktion eine Window-Funktion. Ohne OVER passiert nichts davon.

## Syntax

```sql
SUM(umsatz) OVER (
    PARTITION BY region    -- welche Zeilen gehoeren zusammen
    ORDER BY monat         -- in welcher Reihenfolge
)
```

Beide Teile sind optional. Die Reihenfolge ist fix.

| Teil | Frage | Fehlt er? |
|------|-------|-----------|
| PARTITION BY | Welche Gruppe? | Alle Zeilen sind eine Gruppe |
| ORDER BY | Welche Reihenfolge? | Keine, das Fenster ist die ganze Gruppe |

## Drei Stufen, drei Ergebnisse

Ohne OVER:

```sql
SELECT SUM(umsatz) FROM verkaeufe;      -- 910, eine einzige Zeile
```

Mit leerem OVER:

```sql
SELECT region, umsatz, SUM(umsatz) OVER () AS gesamt FROM verkaeufe;
```

Alle sechs Zeilen bleiben, überall steht 910 daneben.

Mit PARTITION BY und ORDER BY:

```sql
SELECT region, monat, umsatz,
       SUM(umsatz) OVER (PARTITION BY region ORDER BY monat) AS laufend
FROM verkaeufe;
```

| region | monat | umsatz | laufend |
|--------|-------|--------|---------|
| Nord | 2026-01 | 100 | 100 |
| Nord | 2026-02 | 120 | 220 |
| Nord | 2026-03 | 90  | 310 |

```
ohne ORDER BY            mit ORDER BY
Fenster = ganze Gruppe   Fenster waechst mit jeder Zeile
[100 120 90] -> 310      [100        ] -> 100
[100 120 90] -> 310      [100 120    ] -> 220
[100 120 90] -> 310      [100 120  90] -> 310
```

ORDER BY in der OVER-Klammer macht aus einer Gruppensumme eine laufende Summe. Das ist der häufigste Aha-Moment.

## Achtung

Ohne OVER verlangt die Datenbank ein GROUP BY.

Das ORDER BY in OVER steuert die Rechnung. Das ORDER BY am Ende der Abfrage steuert die Ausgabe. Du brauchst oft beide.

## Quellen

- Microsoft Learn, OVER Clause: https://learn.microsoft.com/en-us/sql/t-sql/queries/select-over-clause-transact-sql
- PostgreSQL 18 Doku, 3.5 Window Functions: https://www.postgresql.org/docs/current/tutorial-window.html
