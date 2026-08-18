
Dokumentorientierte Datenbanken gehören zur Gruppe der **NoSQL-Datenbanken**. Anstatt Daten wie bei klassischen SQL-Datenbanken in Tabellen mit Zeilen und Spalten zu speichern, werden die Daten in **Dokumenten** gespeichert.

Als konkretes Beispiel wird hier **MongoDB** verwendet, da MongoDB eine der bekanntesten dokumentorientierten Datenbanken ist.

---

# 1. Einführung

## 1.1 Was ist eine dokumentorientierte Datenbank?

Eine dokumentorientierte Datenbank speichert Informationen in sogenannten **Dokumenten**.

Ein Dokument kann man sich ähnlich wie ein **JSON-Objekt** vorstellen. MongoDB verwendet dafür intern das Format **BSON**, eine binäre Form von JSON, die zusätzliche Datentypen unterstützt. Ein Dokument besteht aus **Feldern und Werten** und kann auch weitere Objekte und Arrays enthalten.

Ein Dokument könnte zum Beispiel so aussehen:

```json
{
  "name": "Max Mustermann",
  "alter": 18,
  "email": "max@example.com",
  "adresse": {
    "stadt": "Villach",
    "plz": 9500
  },
  "hobbys": [
    "Gaming",
    "Programmieren",
    "Fußball"
  ]
}
```

Hier befinden sich alle wichtigen Informationen über die Person in **einem einzigen Dokument**.

MongoDB speichert solche Dokumente in sogenannten **Collections**. Eine Collection ist ungefähr mit einer Tabelle bei SQL vergleichbar.

### Vergleich der Begriffe

|SQL|Dokumentorientierte Datenbank|
|---|---|
|Datenbank|Datenbank|
|Tabelle|Collection|
|Zeile / Datensatz|Dokument|
|Spalte|Feld|
|Primary Key|`_id`|
|JOIN|Einbettung, Referenzen oder z. B. `$lookup`|

---

## 1.2 Warum brauche ich dokumentorientierte Datenbanken?

Dokumentorientierte Datenbanken sind besonders praktisch, wenn die Daten **nicht immer exakt gleich aufgebaut sind**.

Bei einer klassischen SQL-Datenbank muss normalerweise vorher relativ genau definiert werden, welche Spalten eine Tabelle besitzt.

Bei einer Dokumentdatenbank können Dokumente dagegen unterschiedlich aufgebaut sein.

Zum Beispiel:

```json
{
  "name": "Nico",
  "alter": 18
}
```

und:

```json
{
  "name": "Max",
  "alter": 19,
  "email": "max@example.com",
  "discord": "max123"
}
```

Beide Dokumente können sich in derselben Collection befinden.

Diese Flexibilität ist besonders praktisch bei Anwendungen, bei denen sich die Datenstruktur häufig verändert. MongoDB unterstützt zusätzlich Schema-Validierung, wenn man trotz der Flexibilität bestimmte Regeln erzwingen möchte.

### Typische Einsatzgebiete

Dokumentorientierte Datenbanken eignen sich zum Beispiel gut für:

- Webanwendungen
    
- Mobile Apps
    
- Benutzerprofile
    
- Produktkataloge
    
- Online-Shops
    
- Content-Management-Systeme
    
- Spiele und Spielerdaten
    
- APIs
    
- Anwendungen mit häufig wechselnder Datenstruktur
    

Ein großer Vorteil ist außerdem, dass verschachtelte Daten direkt zusammen gespeichert werden können. Dadurch kann man Daten häufig mit einer einzigen Abfrage laden, anstatt mehrere Tabellen verbinden zu müssen.

---

## 1.3 Welche Tools und Datenbanken gibt es?

Es gibt verschiedene dokumentorientierte Datenbanken.

### MongoDB

**MongoDB** ist eine sehr bekannte dokumentorientierte Datenbank. Daten werden als BSON-Dokumente gespeichert.

Dazu gehören mehrere Werkzeuge:

- **MongoDB Server** → eigentliche Datenbank
    
- **mongosh** → Kommandozeile für MongoDB
    
- **MongoDB Compass** → grafische Benutzeroberfläche
    
- **MongoDB Atlas** → MongoDB als Cloud-Dienst
    

---

### Apache CouchDB

**Apache CouchDB** ist ebenfalls eine dokumentorientierte Datenbank. Sie speichert Daten als JSON-Dokumente und stellt unter anderem eine HTTP-Schnittstelle zur Verfügung.

---

### Firebase Cloud Firestore

**Cloud Firestore** von Google ist eine dokumentorientierte NoSQL-Datenbank.

Die Struktur besteht aus:

```text
Collection
    ↓
Document
    ↓
Subcollection
    ↓
Document
```

Firestore speichert Daten in Dokumenten, welche wiederum in Collections organisiert werden.

Firestore wird häufig für Web- und Mobile-Anwendungen verwendet.

---

### RavenDB

**RavenDB** ist ebenfalls eine dokumentorientierte Datenbank und unterstützt unter anderem Dokumente, Beziehungen zwischen Dokumenten, Revisionsstände und weitere Funktionen.

---

# 2. Setup

Für das Setup verwenden wir **MongoDB**.

MongoDB kann auf verschiedene Arten verwendet werden:

1. Native Installation
    
2. Docker
    
3. Cloud über MongoDB Atlas
    

MongoDB stellt eine Community Edition für lokale Installationen bereit.

---

## 2.1 Native Installation

**Nativ** bedeutet, dass MongoDB direkt auf dem Betriebssystem installiert wird.

### Beispiel Windows

### Schritt 1 – MongoDB Community Edition herunterladen

MongoDB Community Edition herunterladen und beim Download als Plattform **Windows** auswählen.

Unter Windows wird normalerweise ein `.msi`-Installer verwendet.

---

### Schritt 2 – Installation starten

Den Installer öffnen.

Als Setup kann normalerweise:

```text
Complete
```

gewählt werden.

MongoDB kann außerdem direkt als **Windows Service** installiert werden. Dadurch kann MongoDB automatisch im Hintergrund gestartet werden.

---

### Schritt 3 – MongoDB Shell installieren

Für Befehle verwendet man:

```text
mongosh
```

`mongosh` ist die Kommandozeilen-Anwendung von MongoDB.

---

### Schritt 4 – Verbindung testen

In einem Terminal:

```bash
mongosh --port 27017
```

Der Standardport von MongoDB ist:

```text
27017
```

---

### Schritt 5 – Verbindung erfolgreich

Wenn die Verbindung funktioniert, befindet man sich in der MongoDB Shell.

Hier können jetzt MongoDB-Befehle ausgeführt werden.

---

## 2.2 Installation mit Docker

MongoDB kann auch als Docker-Container gestartet werden.

Der Vorteil dabei ist, dass MongoDB nicht direkt auf dem Betriebssystem installiert werden muss.

Docker eignet sich besonders gut für:

- Entwicklung
    
- Tests
    
- Schulprojekte
    
- schnelles Erstellen und Entfernen einer Datenbank
    
- verschiedene MongoDB-Versionen
    

MongoDB stellt dafür ein offizielles Community-Docker-Image bereit.

### Image herunterladen

```bash
docker pull mongodb/mongodb-community-server:latest
```

### Container starten

```bash
docker run --name mongodb -p 27017:27017 -d mongodb/mongodb-community-server:latest
```

Bedeutung:

```text
--name mongodb
```

Der Container bekommt den Namen `mongodb`.

```text
-p 27017:27017
```

Der MongoDB-Port des Containers wird auf den Computer weitergeleitet.

```text
-d
```

Der Container läuft im Hintergrund.

Danach ist MongoDB über:

```text
localhost:27017
```

erreichbar.

---

### Prüfen, ob MongoDB läuft

```bash
docker container ls
```

---

### Verbindung herstellen

```bash
mongosh --port 27017
```

Die offiziellen MongoDB-Docker-Anleitungen verwenden genau diesen Ablauf zum Starten und anschließenden Verbinden mit dem Container.

---

## 2.3 MongoDB Compass

Wer nicht nur mit der Kommandozeile arbeiten möchte, kann **MongoDB Compass** verwenden.

Compass ist eine grafische Oberfläche, mit der man zum Beispiel:

- Datenbanken erstellen
    
- Collections anzeigen
    
- Dokumente erstellen
    
- Dokumente bearbeiten
    
- Dokumente löschen
    
- Daten suchen und filtern
    
- JSON- und CSV-Daten importieren oder exportieren
    

kann. MongoDB Compass unterstützt unter anderem JSON- und CSV-Importe.

---

# 3. Nutzung – CRUD Operations

Die wichtigsten Operationen einer Datenbank nennt man **CRUD**.

CRUD steht für:

|Buchstabe|Bedeutung|Deutsch|
|---|---|---|
|C|Create|Erstellen|
|R|Read|Lesen|
|U|Update|Aktualisieren|
|D|Delete|Löschen|

MongoDB stellt für alle vier CRUD-Bereiche eigene Befehle bereit.

---

## 3.1 Datenbank auswählen

Zuerst wählen wir eine Datenbank aus:

```javascript
use schule
```

Jetzt arbeiten wir mit der Datenbank:

```text
schule
```

Eine Collection wird bei MongoDB automatisch erstellt, sobald zum ersten Mal ein Dokument darin eingefügt wird.

---

## 3.2 CREATE – Dokument erstellen

Wir erstellen einen Schüler:

```javascript
db.schueler.insertOne({
    name: "Max",
    alter: 18,
    klasse: "4A",
    email: "max@example.com"
})
```

`schueler` ist unsere Collection.

MongoDB erzeugt zusätzlich automatisch ein eindeutiges Feld:

```text
_id
```

Das Dokument sieht danach ungefähr so aus:

```json
{
  "_id": "...",
  "name": "Max",
  "alter": 18,
  "klasse": "4A",
  "email": "max@example.com"
}
```

Für mehrere Dokumente kann verwendet werden:

```javascript
db.schueler.insertMany([
    {
        name: "Max",
        alter: 18
    },
    {
        name: "Anna",
        alter: 17
    },
    {
        name: "Leon",
        alter: 19
    }
])
```

MongoDB stellt dafür `insertOne()` und `insertMany()` bereit.

---

# 3.3 READ – Dokumente auslesen

Alle Schüler anzeigen:

```javascript
db.schueler.find()
```

Nur einen bestimmten Schüler suchen:

```javascript
db.schueler.find({
    name: "Max"
})
```

Nach mehreren Bedingungen suchen:

```javascript
db.schueler.find({
    alter: 18,
    klasse: "4A"
})
```

---

### Vergleichsoperatoren

Zum Beispiel alle Schüler über 17:

```javascript
db.schueler.find({
    alter: { $gt: 17 }
})
```

Wichtige Operatoren:

|Operator|Bedeutung|
|---|---|
|`$gt`|größer als|
|`$gte`|größer oder gleich|
|`$lt`|kleiner als|
|`$lte`|kleiner oder gleich|
|`$ne`|nicht gleich|
|`$in`|Wert befindet sich in einer Liste|

`find()` liefert Dokumente einer Collection und kann Filterbedingungen verwenden.

---

# 3.4 UPDATE – Dokument verändern

Angenommen Max wird 19 Jahre alt.

```javascript
db.schueler.updateOne(
    { name: "Max" },
    {
        $set: {
            alter: 19
        }
    }
)
```

Der erste Teil:

```javascript
{ name: "Max" }
```

bestimmt, **welches Dokument gesucht wird**.

Der zweite Teil:

```javascript
$set
```

bestimmt, **welche Daten verändert werden**.

Mehrere Dokumente können mit:

```javascript
db.schueler.updateMany(...)
```

aktualisiert werden. MongoDB verarbeitet dabei die einzelnen Dokumentänderungen jeweils atomar; `updateMany()` als Gesamtoperation ist aber keine einzige atomare Transaktion.

---

# 3.5 DELETE – Dokument löschen

Einen bestimmten Schüler löschen:

```javascript
db.schueler.deleteOne({
    name: "Max"
})
```

Alle Schüler mit einer bestimmten Klasse löschen:

```javascript
db.schueler.deleteMany({
    klasse: "4A"
})
```

MongoDB stellt dafür `deleteOne()` und `deleteMany()` bereit.

---

## CRUD Zusammenfassung

```text
CREATE
db.schueler.insertOne(...)

READ
db.schueler.find(...)

UPDATE
db.schueler.updateOne(...)

DELETE
db.schueler.deleteOne(...)
```

Damit können die vier grundlegenden Datenbankoperationen durchgeführt werden.

---

# 4. Vergleich mit SQL

## 4.1 Was kann eine dokumentorientierte Datenbank besser als SQL?

Es sollte nicht unbedingt gesagt werden:

> „MongoDB kann mehr als SQL.“

Beide Systeme haben unterschiedliche Stärken.

### Vorteil 1 – Flexiblere Datenstruktur

Bei Dokumentdatenbanken müssen nicht alle Dokumente exakt dieselben Felder besitzen.

Beispiel:

```json
{
  "name": "Max",
  "alter": 18
}
```

und:

```json
{
  "name": "Anna",
  "alter": 17,
  "discord": "anna123",
  "hobbys": ["Gaming", "Musik"]
}
```

können problemlos gemeinsam gespeichert werden.

---

### Vorteil 2 – Verschachtelte Daten

Informationen können direkt innerhalb eines Dokuments gespeichert werden.

```json
{
  "name": "Max",

  "adresse": {
    "stadt": "Villach",
    "plz": 9500,
    "straße": "Beispielstraße 10"
  }
}
```

MongoDB unterstützt Dokumente, verschachtelte Dokumente und Arrays direkt innerhalb eines Datensatzes.

---

### Vorteil 3 – Weniger JOINs notwendig

In SQL könnten Benutzer und Adresse beispielsweise auf verschiedene Tabellen verteilt werden.

Bei einer Dokumentdatenbank kann die Adresse direkt im Benutzer gespeichert werden.

Dadurch können benötigte Informationen häufig gemeinsam geladen werden.

MongoDB empfiehlt in passenden Fällen das Einbetten von Daten, weil dadurch zusätzliche Abfragen bzw. `$lookup`-Operationen vermieden werden können.

---

### Vorteil 4 – Gute Abbildung von Objekten

Dokumente sehen häufig ähnlich aus wie Objekte, die man in Programmiersprachen verwendet.

Zum Beispiel in JavaScript:

```javascript
const user = {
    name: "Max",
    alter: 18,
    hobbys: ["Gaming", "Fußball"]
};
```

und in MongoDB:

```json
{
  "name": "Max",
  "alter": 18,
  "hobbys": ["Gaming", "Fußball"]
}
```

MongoDB beschreibt sein Dokumentmodell ausdrücklich als Modell, das sich gut an Objektstrukturen aus Programmen anpassen lässt.

---

# 4.2 Was ist schlechter als bei SQL?

## Beziehungen können komplizierter werden

SQL-Datenbanken sind sehr gut geeignet, wenn viele Datensätze miteinander verbunden sind.

Zum Beispiel:

```text
Kunde
   ↓
Bestellung
   ↓
Bestellposition
   ↓
Produkt
   ↓
Hersteller
```

Bei einer relationalen Datenbank können diese Beziehungen klar über Tabellen, Primärschlüssel und Fremdschlüssel dargestellt werden.

Dokumentdatenbanken verwenden dagegen häufig:

- eingebettete Dokumente
    
- Referenzen
    
- `$lookup`
    

MongoDB unterstützt Beziehungen über Referenzen, dennoch muss man genau überlegen, ob Daten eingebettet oder getrennt gespeichert werden sollen.

---

## Daten können doppelt gespeichert werden

Bei Dokumentdatenbanken wird bewusst häufig **Denormalisierung** verwendet.

Beispiel:

```json
{
  "bestellung": 1001,
  "kunde": {
    "name": "Max",
    "stadt": "Villach"
  }
}
```

Dadurch können Daten schneller gelesen werden.

Der Nachteil:

Wenn sich der Name von Max ändert und er in 100 Bestellungen gespeichert wurde, könnten mehrere Dokumente aktualisiert werden müssen.

MongoDB weist darauf hin, dass eingebettete beziehungsweise duplizierte Daten die Lesezugriffe vereinfachen können, gleichzeitig aber Daten-Duplikation entsteht.

---

## SQL hat normalerweise ein klareres Schema

Bei SQL wird normalerweise genau definiert:

```text
name = VARCHAR
alter = INT
email = VARCHAR
```

Bei einer Dokumentdatenbank kann ohne ausreichende Kontrolle beispielsweise Folgendes entstehen:

```json
{
  "alter": 18
}
```

```json
{
  "alter": "achtzehn"
}
```

```json
{
  "age": 18
}
```

Das ist zwar flexibel, kann aber später Probleme verursachen.

MongoDB bietet deshalb **Schema Validation**, mit der Pflichtfelder, Datentypen und andere Regeln festgelegt werden können.

---

# 4.3 Welche Pitfalls gibt es?

## Pitfall 1 – „Schemafrei“ bedeutet nicht „ohne Struktur“

Einer der größten Fehler ist zu denken:

> „Bei MongoDB brauche ich mir über die Datenstruktur keine Gedanken machen.“

Das stimmt nicht.

Auch bei einer Dokumentdatenbank sollte vorher überlegt werden:

- Welche Informationen gehören zusammen?
    
- Was wird oft gemeinsam abgefragt?
    
- Welche Daten werden oft verändert?
    
- Welche Daten können wachsen?
    
- Welche Daten sollten referenziert werden?
    

MongoDB empfiehlt ausdrücklich, das Datenmodell anhand der Anforderungen und Abfragen der Anwendung zu planen.

---

## Pitfall 2 – Unendlich wachsende Arrays

Folgendes wäre problematisch:

```json
{
  "video": "Mein Video",

  "comments": [
    "...",
    "...",
    "...",
    "...",
    "immer mehr Kommentare"
  ]
}
```

Wenn die Anzahl der Kommentare ständig weiter wächst, wächst auch das Dokument immer weiter.

MongoDB bezeichnet solche Strukturen als **Unbounded Arrays** und empfiehlt für große oder häufig aktualisierte Daten beispielsweise eigene Collections oder Referenzen.

---

## Pitfall 3 – Maximale Dokumentgröße

Ein einzelnes MongoDB-BSON-Dokument darf maximal **16 MiB** groß sein. Für größere Dateien beziehungsweise Datenmengen stellt MongoDB unter anderem GridFS bereit.

Das bedeutet:

Nicht alles sollte in ein riesiges Dokument gepackt werden.

---

## Pitfall 4 – Zu viele duplizierte Daten

Denormalisierung kann Abfragen schneller und einfacher machen.

Zu viel Duplizierung führt aber dazu, dass dieselbe Information an mehreren Stellen aktualisiert werden muss.

Dadurch besteht die Gefahr von **inkonsistenten Daten**.

MongoDB unterstützt für solche Situationen auch Transaktionen über mehrere Dokumente und Collections.

---

## Pitfall 5 – Zu viele Transaktionen

MongoDB unterstützt Multi-Document-Transaktionen, sie sollten aber nicht als Ersatz für ein gutes Datenmodell betrachtet werden.

Transaktionen können zusätzliche Kosten für Performance verursachen. Außerdem benötigen Multi-Document-Transaktionen ein Replica Set oder einen Sharded Cluster; ein einfacher Standalone-Server unterstützt sie nicht.

Deshalb sollte man Daten, die häufig gemeinsam geändert werden, wenn sinnvoll gemeinsam in einem Dokument speichern.

Eine einzelne Änderung an einem MongoDB-Dokument ist atomar.

---

## Pitfall 6 – Sicherheit

Eine lokale Testdatenbank sollte nicht einfach ohne Sicherheitskonfiguration ins Internet gestellt werden.

Wenn eine MongoDB-Instanz über eine öffentlich erreichbare IP verfügbar gemacht wird, empfiehlt MongoDB mindestens Authentifizierung und eine abgesicherte Netzwerkkonfiguration.

Für lokale Entwicklung ist beispielsweise:

```text
localhost:27017
```

ausreichend.

---

# SQL vs. Dokumentorientierte Datenbank – Zusammenfassung

|Bereich|SQL|Dokumentorientiert|
|---|---|---|
|Speicherung|Tabellen|Dokumente|
|Datenstruktur|eher streng|flexibel|
|Verschachtelte Daten|meist mehrere Tabellen|direkt möglich|
|Beziehungen|sehr stark|möglich, aber anders modelliert|
|JOINs|sehr verbreitet|häufig durch Embedding vermieden|
|Schema|vorher definiert|flexibel / optional validierbar|
|Daten-Duplikation|eher gering|häufiger|
|Objektorientierte Daten|Mapping oft notwendig|sehr natürliche Abbildung|
|CRUD|SQL-Befehle|z. B. MongoDB Query Language|
|Gute Verwendung|stark relationale Daten|flexible/hierarchische Daten|

---

# Fazit

Eine **dokumentorientierte Datenbank** speichert Daten nicht hauptsächlich in Tabellen, sondern in Dokumenten.

Der größte Vorteil ist die **flexible und hierarchische Datenstruktur**. Daten wie Benutzer, Adressen, Einstellungen oder Arrays können gemeinsam in einem Dokument gespeichert werden.

Dadurch eignen sich dokumentorientierte Datenbanken besonders gut für moderne Webanwendungen, APIs, Apps und Systeme, bei denen sich die Datenstruktur häufig verändert.

SQL-Datenbanken sind dagegen häufig besser geeignet, wenn sehr viele klar definierte Beziehungen zwischen Daten bestehen und eine stark strukturierte relationale Datenstruktur benötigt wird.

Man kann sich den Unterschied vereinfacht so merken:

> **SQL:** „Ich teile meine Daten sauber auf Tabellen auf und verbinde sie miteinander.“

> **Dokumentdatenbank:** „Ich speichere Daten, die zusammengehören, möglichst gemeinsam in einem Dokument.“

Für erste Übungen eignet sich **MongoDB** besonders gut, da es lokal, über Docker oder in der Cloud verwendet werden kann und CRUD-Operationen einfach nachvollziehbar sind.

