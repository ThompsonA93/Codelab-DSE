# RANK

RANK vergibt Platzierungen und erlaubt Gleichstand. Nach einem Gleichstand überspringt es Nummern.

Wie bei Olympia. Zwei Silbermedaillen, keine Bronze, die nächste Person ist Vierte.

## Syntax

```sql
RANK() OVER (PARTITION BY region ORDER BY umsatz DESC)
```

Klammer leer, ORDER BY Pflicht. DESC heißt: größter Wert ist Platz 1.

## Der Unterschied zu ROW_NUMBER

Er zeigt sich nur bei gleichen Werten.

| name | punkte | ROW_NUMBER | RANK | DENSE_RANK |
|------|--------|-----------|------|------------|
| A | 30 | 1 | 1 | 1 |
| B | 20 | 2 | 2 | 2 |
| C | 20 | 3 | 2 | 2 |
| D | 10 | 4 | 4 | 3 |

```
punkte:      30   20   20   10
ROW_NUMBER    1    2    3    4    zaehlt stur durch
RANK          1    2    2    4    Gleichstand, dann Sprung
DENSE_RANK    1    2    2    3    Gleichstand, kein Sprung
```

RANK beantwortet: wie viele stehen vor mir, plus eins. Vor D stehen drei Personen, also Platz 4.

## Beispiel

```sql
SELECT region, monat, umsatz,
       RANK() OVER (PARTITION BY region ORDER BY umsatz DESC) AS rang
FROM verkaeufe;
```

| region | monat | umsatz | rang |
|--------|-------|--------|------|
| Nord | 2026-02 | 120 | 1 |
| Nord | 2026-01 | 100 | 2 |
| Nord | 2026-03 | 90  | 3 |

Ohne Gleichstand sieht RANK aus wie ROW_NUMBER.

## Welche Funktion wann

| Du willst | Nimm |
|-----------|------|
| genau 2 Zeilen pro Gruppe | ROW_NUMBER |
| alle mit den 2 besten Werten, notfalls 3 Zeilen | RANK |
| die 2 besten Werte-Stufen | DENSE_RANK |
| n gleich große Töpfe | NTILE(n) |

## Achtung

1, 2, 2, 4 ist kein Fehler. Willst du 1, 2, 2, 3, nimm DENSE_RANK.

DESC nicht vergessen, sonst ist der kleinste Wert Platz 1.

## Quellen

- MySQL 8.0 Manual, Window Function Descriptions: https://dev.mysql.com/doc/refman/8.0/en/window-function-descriptions.html
- PostgreSQL 18 Doku, 9.22 Window Functions: https://www.postgresql.org/docs/current/functions-window.html
