# ROW_NUMBER

ROW_NUMBER nummeriert die Zeilen einer Gruppe durch: 1, 2, 3. Zwei Zeilen bekommen nie dieselbe Nummer.

## Syntax

```sql
ROW_NUMBER() OVER (PARTITION BY region ORDER BY umsatz DESC)
```

Die Klammer bleibt leer, die Funktion nimmt kein Argument. ORDER BY ist Pflicht, sonst gibt es keine Reihenfolge zum Nummerieren.

## Beispiel

```sql
SELECT region, monat, umsatz,
       ROW_NUMBER() OVER (PARTITION BY region ORDER BY umsatz DESC) AS nr
FROM verkaeufe;
```

| region | monat | umsatz | nr |
|--------|-------|--------|----|
| Nord | 2026-02 | 120 | 1 |
| Nord | 2026-01 | 100 | 2 |
| Nord | 2026-03 | 90  | 3 |
| Sued | 2026-03 | 250 | 1 |
| Sued | 2026-01 | 200 | 2 |
| Sued | 2026-02 | 150 | 3 |

Der Zähler startet in jeder Region wieder bei 1.

## Top N pro Gruppe

Das wichtigste Muster mit ROW_NUMBER. Es löst gefühlt die Hälfte aller Aufgaben.

```sql
SELECT * FROM (
    SELECT region, monat, umsatz,
           ROW_NUMBER() OVER (PARTITION BY region ORDER BY umsatz DESC) AS nr
    FROM verkaeufe
) t
WHERE nr <= 2;
```

Die Unterabfrage brauchst du, weil Window-Funktionen in WHERE verboten sind.

## Duplikate finden

```sql
SELECT * FROM (
    SELECT id, email, ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS nr
    FROM kunden
) t
WHERE nr > 1;
```

Alles mit nr über 1 ist ein Duplikat.

## Achtung

Bei gleichem Umsatz entscheidet ROW_NUMBER willkürlich, wer die 2 und wer die 3 bekommt. Beim nächsten Ausführen kann es anders sein. Setz eine zweite Sortierspalte, etwa `ORDER BY umsatz DESC, monat`.

Willst du bei Gleichstand denselben Platz vergeben, nimm RANK.

## Quellen

- PostgreSQL 18 Doku, 3.5 Window Functions: https://www.postgresql.org/docs/current/tutorial-window.html
- MySQL 8.0 Manual, Window Function Descriptions: https://dev.mysql.com/doc/refman/8.0/en/window-function-descriptions.html
