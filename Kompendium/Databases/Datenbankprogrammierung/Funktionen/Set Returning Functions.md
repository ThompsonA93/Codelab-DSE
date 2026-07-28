
- Sonderform von Funktionen, die eine Menge von Zeilen (Tabelle) statt eines Einzelwerts zurückgeben.

- Werden im Kopf meist mit `RETURNS TABLE(...)` oder `RETURNS SETOF datentyp` definiert.

- Nutzen den Befehl `RETURN QUERY`, um das Ergebnis einer SELECT-Abfrage direkt zurückzugeben.

- Nutzen den Befehl `RETURN NEXT` innerhalb von Schleifen, um Zeile für Zeile an die Ergebnismenge anzuhängen.  

- ##### Fazit: Funktionen, die eine ganze Tabelle statt nur eines einzelnen Wertes ausgeben.