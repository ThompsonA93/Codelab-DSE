
## 1) Einführung

### Was ist eine spaltenorientierte Datenbank?

Eine **spaltenorientierte Datenbank** (Column-Oriented Database) speichert Daten nicht wie klassische relationale Datenbanken **zeilenweise**, sondern **spaltenweise**.


Beispiel klassische SQL-Datenbank.

| ID  | Name | Alter | Stadt |
| --- | ---- | ----- | ----- |
| 1   | Max  | 25    | Wien  |
| 2   | Anna | 30    | Graz  |
Speicherung:
```
Zeile 1: 1, Max, 25, Wien
Zeile 2: 2, Anna, 30, Graz
```
Spaltenorientierte Speicherung:
```
ID:
1
2

Name:
Max
Anna

Alter:
25
30

Stadt:
Wien
Graz
```
Die Werte einer Spalte liegen direkt hintereinander im Speicher. Dadurch können bestimmte Abfragen extrem schnell ausgeführt werden.

Bekannte spaltenorientierte Datenbanken:

- Apache Cassandra
- ClickHouse
- Apache HBase
- Google Bigtable


---

## Beispiele für spaltenorientierte Datenbanken

- Apache Cassandra
- ClickHouse
- Apache HBase
- Google Bigtable


---

# Warum braucht man spaltenorientierte Datenbanken?

Spaltenorientierte Datenbanken werden verwendet, wenn sehr große Datenmengen verarbeitet werden müssen.

Typische Einsatzbereiche:

- Big Data
- Datenanalyse
- Log-Auswertung
- Monitoring-Systeme
- Machine Learning
- Business Intelligence


## Beispiel

Ein Unternehmen speichert Milliarden Verkaufsdaten:

Datum | Produkt | Preis | Kunde

Eine SQL-Datenbank muss viele komplette Zeilen durchsuchen.

Eine spaltenorientierte Datenbank kann direkt nur die benötigte Spalte laden:

```sql
SELECT SUM(Preis)
FROM Verkäufe;
```

# 2. Installation lokal

## Beispiel: Apache Cassandra

## Voraussetzungen

Benötigt:

- Java Runtime Environment
- Cassandra Server
- CQL Shell

Download:

[https://cassandra.apache.org/](https://cassandra.apache.org/)

## Installation unter Windows

### 1. Java installieren

Überprüfen:

java -version

---

### 2. Cassandra herunterladen

Cassandra herunterladen und entpacken.

---

### 3. Cassandra starten

```
bin\cassandra.bat
```
---

### 4. Verbindung herstellen

```
bin\cqlsh
```

Danach kann Cassandra mit CQL (Cassandra Query Language) gesteuert werden.

Beispiel:

```sql
CREATE KEYSPACE test;
```


# 3. CRUD Operationen

CRUD bedeutet:

| Begriff | Bedeutung       |
| ------- | --------------- |
| Create  | Daten erstellen |
| Read    | Daten lesen     |
| Update  | Daten ändern    |
| Delete  | Daten löschen   |

---
# Create (Daten erstellen)

## Keyspace erstellen

```sql
CREATE KEYSPACE shop

WITH replication = {

'class':'SimpleStrategy',

'replication_factor':1

};
```
---
Datenbank auswählen:
```sql
USE shop;
```
---
## Tabelle erstellen

```sql
CREATE TABLE kunden (

id UUID PRIMARY KEY,

name TEXT,

alter INT

);
```
---

## Daten einfügen

```sql
INSERT INTO kunden(id,name,alter)

VALUES(uuid(),'Max',25);
```
---
# Read (Daten lesen)

Alle Daten anzeigen:
```sql
SELECT * FROM kunden;

Bestimmten Datensatz suchen:

SELECT *

FROM kunden

WHERE id='123';
```
---
# Update (Daten ändern)

```sql
UPDATE kunden

SET alter = 26

WHERE id='123';
```
---
# Delete (Daten löschen)

```sql
DELETE FROM kunden

WHERE id='123';
```
---

# 4. Vergleich zu SQL-Datenbanken

| Eigenschaft   | SQL Datenbank     | Spaltenorientierte Datenbank |
| ------------- | ----------------- | ---------------------------- |
| Speicherung   | Zeilen            | Spalten                      |
| Beispiele     | MySQL, PostgreSQL | Cassandra, ClickHouse        |
| Datenmenge    | Mittel bis groß   | Sehr große Datenmengen       |
| Skalierung    | Meist vertikal    | Horizontal                   |
| Joins         | Sehr gut          | Eingeschränkt                |
| Analysen      | Gut               | Sehr schnell                 |
| Transaktionen | Stark             | Eingeschränkt                |

# Vorteile gegenüber SQL

## 1. Schnellere Analyse

Bei großen Datenmengen werden nur benötigte Spalten gelesen.

Beispiel:
```sql
SELECT AVG(preis)

FROM verkauf;
```
Die Datenbank muss nicht die komplette Zeile laden.

## 2. Bessere Skalierung

Spaltenorientierte Datenbanken können einfach auf mehrere Server verteilt werden.

Beispiel:
```
Server 1

Server 2

Server 3

Server 4
```
Dadurch können sehr große Datenmengen verarbeitet werden.

## 3. Hohe Schreibgeschwindigkeit

Geeignet für:

- Sensordaten
- Webseiten-Logs
- Klickdaten
- Echtzeitdaten
---
# Nachteile / Pitfalls

## 1. Schlechte Unterstützung für JOINs

SQL:
```sql
SELECT *

FROM kunden

JOIN bestellungen;
```
funktioniert einfach.

Bei spaltenorientierten Datenbanken müssen Daten oft anders aufgebaut werden.

## 2. Mehrfache Speicherung von Daten

Daten werden oft absichtlich doppelt gespeichert.

Vorteile:

- schneller Zugriff

Nachteile:

- mehr Speicherverbrauch
- Änderungen müssen an mehreren Stellen gemacht werden

---

## 3. Nicht für jede Anwendung geeignet

Schlecht geeignet für:

- Banking-Systeme
- komplexe Transaktionen
- Anwendungen mit vielen Beziehungen

Beispiel:

Eine Bank benötigt:

- Kontostände
- Überweisungen
- Transaktionen

Hier sind relationale SQL-Datenbanken besser.

# Zusammenfassung

Spaltenorientierte Datenbanken speichern Daten nach **Spalten statt Zeilen**.

Sie sind besonders geeignet für:

- große Datenmengen
- schnelle Analysen
- Big Data
- Echtzeitverarbeitung

## Vorteile

✅ Sehr schnelle Abfragen bei großen Datenmengen  
✅ Gute horizontale Skalierung  
✅ Hohe Schreibgeschwindigkeit

## Nachteile

❌ Weniger geeignet für Beziehungen und JOINs  
❌ Mehr Speicherverbrauch durch Duplikate  
❌ Nicht ideal für komplexe Transaktionen

**Fazit:**  
Spaltenorientierte Datenbanken ergänzen klassische SQL-Datenbanken. Sie sind besonders stark bei großen Datenanalysen, während SQL besser für strukturierte Anwendungen mit vielen Beziehungen geeignet ist.

