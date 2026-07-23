
- Ein PL/PG SQL-Befehl zum Ausführen von SQL-Abfragen, deren Ergebnis verworfen wird.

- Wird verwendet, wenn eine Funktion aufgerufen wird, deren Rückgabewert nicht benötigt wird.

- Verhindert Syntaxfehler, da ein normales `SELECT` in PL/PG SQL zwingend eine Zielvariable erwartet.

- Wird häufig bei Funktionen mit `RETURNS VOID` oder zur reinen Prüfung von Bedingungen genutzt.

- ##### Fazit: Ein `SELECT`, dessen Ergebnis ignoriert wird.