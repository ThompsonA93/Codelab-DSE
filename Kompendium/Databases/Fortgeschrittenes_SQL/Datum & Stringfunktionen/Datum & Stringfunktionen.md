# Einführung:

In Datenbanken werden viele verschiedene Arten von Informationen gespeichert, darunter Texte und Datumswerte. Um diese Daten effizient zu verarbeiten, bieten Datenbanksysteme sogenannte **Funktionen** an. Diese ermöglichen es, Daten zu analysieren, zu verändern und für die Ausgabe aufzubereiten.

SQL (_Structured Query Language_) ist eine standardisierte Sprache zur Verwaltung von Datenbanken. Allerdings gibt es verschiedene **SQL-Dialekte**, da unterschiedliche Datenbanksysteme eigene Erweiterungen und Funktionen entwickelt haben. Dadurch können sich Syntax und verfügbare Funktionen zwischen den Datenbanken unterscheiden.

Beispiele für bekannte SQL-Dialekte sind:

- **PostgreSQL** → verwendet eigene Erweiterungen wie `DATE_PART()` und unterstützt den SQL-Standard mit `EXTRACT()`
- **MySQL** → verwendet beispielsweise Funktionen wie `DATE_FORMAT()` oder `YEAR()`
- **Microsoft SQL Server (T-SQL)** → nutzt unter anderem Funktionen wie `DATEPART()` und `GETDATE()`
- **Oracle SQL** → besitzt eigene Funktionen wie `TO_DATE()` und `TO_CHAR()`

Obwohl die grundlegenden SQL-Befehle wie `SELECT`, `INSERT`, `UPDATE` und `DELETE` in vielen Datenbanksystemen ähnlich sind, können sich spezielle Funktionen zur Verarbeitung von Datum- und Textwerten unterscheiden.

Diese Dokumentation bezieht sich auf den SQL-Dialekt **PostgreSQL**. Dabei werden die Funktionen **DATE_PART**, **EXTRACT**, **LOWER** und **UPPER** erklärt und anhand von Beispielen dargestellt.

**Datumfunktionen** ermöglichen es, einzelne Bestandteile aus Datums- und Zeitwerten auszulesen oder Berechnungen mit Zeitangaben durchzuführen.  
**Stringfunktionen** werden verwendet, um Textwerte zu bearbeiten, beispielsweise durch Änderung der Groß- und Kleinschreibung oder Verarbeitung von Zeichenketten.

**KI: Alle Bilder sind KI generiert

#### [[DATE_PART]]

#### [[EXTRACT]]

#### [[LOWER]]

#### [[UPPER]]