# Datenstrukturen und Indizes: Spickzettel aus der Praxis

Als Applikationsentwickler im 3. Lehrjahr stolpert man spätestens bei Performance-Problemen im Backend oder bei Datenbank-Abfragen über Datenstrukturen und Indizes. Hier ist die kompakte Übersicht ohne Schnickschnack.

---

## 1. Die gängigsten Datenstrukturen

### Arrays & Listen
- **Feste Arrays:** Sequenzieller Speicher, direkter Zugriff per Index ($O(1)$).
- **Dynamische Listen (`ArrayList`, `List<T>`):** Wachsen automatisch bei Bedarf. Standard für veränderliche Datenmengen im Code.
- **Verkettete Listen (`LinkedList`):** Schnelles Einfügen/Löschen an beliebigen Stellen, aber langsamer wahlfreier Zugriff ($O(n)$).

### Hash-basierte Strukturen (HashMap, HashSet)
- Speichern Schlüssel-Wert-Paare über eine Hashfunktion.
- Durchschnittlicher Zugriff in $O(1)$.
- Standard für Caching, Lookups und Zuordnungen im Backend.

### Bäume (Trees)
- **Binäre Suchbäume (BST) & Rot-Schwarz-Bäume:** Halten Daten sortiert ($O(\log n)$ für Suchen/Einfügen).
- **B-Bäume / B+-Bäume:** Speziell für Festplatten- und Datenbankspeicher optimiert, da sie viele Einträge pro Knoten halten und die I/O-Zugriffe minimieren.

### Stacks & Queues
- **Stack (LIFO):** Zuletzt rein, zuerst raus (z. B. Undo-Funktion, Callstack).
- **Queue (FIFO):** Zuerst rein, zuerst raus (z. B. Message Broker, Background-Jobs, Task-Queues).

---

## 2. Die wichtigsten Indextypen

### B-Tree / B+-Tree Index
- Der Standard in relationalen Datenbanken (PostgreSQL, MySQL, Oracle).
- Balancierter Baum, der Daten sortiert hält.
- Unterstützt exakte Lookups genauso wie Bereichsabfragen und Sortierungen.

### Hash-Index
- Basiert auf einer internen Hash-Tabelle.
- Extrem schnell für exakte Gleichheit (`=`), aber völlig ungeeignet für Bereiche (`>`, `<`, `BETWEEN`) oder Sortierungen (`ORDER BY`).

### Invertierter Index
- Kerntechnologie von Suchmaschinen wie Elasticsearch oder Lucene.
- Trennt Text in einzelne Tokens (Wörter) auf und verknüpft jedes Token mit einer Liste von Dokument-IDs, in denen es vorkommt.

### Bitmap-Index
- Verwendet für jeden möglichen Wert einer Spalte ein Bit-Array (0 oder 1).
- Hochgradig effizient für Filteroperationen (`AND`, `OR`) auf Spalten mit geringer Kardinalität (wenige unterschiedliche Werte).

### LSM-Tree (Log-Structured Merge-tree)
- Schreibt Daten zuerst sequenziell in den Arbeitsspeicher (MemTable) und flasht sie später sortiert auf die Disk (SSTables).
- Optimal für extrem schreibintensive Workloads.

---

## 3. Welchen Index nimmt man wofür?

### Relationale Datenbank-Tabellen (SQL)
- **Typische Abfragen:** Primärschlüssel-Lookups, Fremdschlüssel-Joins, Datumsbereiche, Sortierungen.
- **Passender Index:** **B-Tree / B+-Tree**
- **Warum:** Weil er der Allrounder ist. Sowohl `WHERE id = 42` als auch `WHERE created_at >= '2024-01-01' ORDER BY created_at` laufen damit in $O(\log n)$.

### Exakte Point-Lookups & Key-Value-Caches
- **Typische Abfragen:** Sessions abrufen, Token validieren, reine ID-Gleichheitsabfragen.
- **Passender Index:** **Hash-Index**
- **Warum:** Liefert $O(1)$-Geschwindigkeit. Wenn niemals nach Bereichen gesucht oder sortiert werden muss, spart das Overhead.

### Volltextsuche & Log-Analyse
- **Typische Abfragen:** Suchleiste im Webshop, Textfilter auf Blogposts, Freitextsuche in Logfiles.
- **Passender Index:** **Invertierter Index** (aufgebaut aus Hash-Maps/Tries + Posting Lists)
- **Warum:** Ein B-Tree versagt bei `LIKE '%begriff%'` (Full Table Scan). Der invertierte Index springt direkt zum gesuchten Begriff und kennt sofort alle relevanten Dokumente.

### Spalten mit wenigen distinkten Werten (Low Cardinality)
- **Typische Abfragen:** Filter auf Statusfelder (`status IN ('open', 'in_progress')`), Boolean-Flags (`is_active = true`), Ländercodes in Data Warehouses.
- **Passender Index:** **Bitmap-Index**
- **Warum:** Die Datenbank kann komplexe Kombinationen aus mehreren Filtern über extrem schnelle Bitweise-Operationen (`AND`, `OR`, `XOR`) im RAM berechnen.

### Write-Heavy NoSQL-Systeme & Time-Series
- **Typische Abfragen:** Schnelles Schreiben von IoT-Sensordaten, Event-Streams, Audit-Logs (z. B. Cassandra, RocksDB).
- **Passender Index:** **LSM-Tree**
- **Warum:** Wandelt zufällige Schreibzugriffe auf der Platte in lineare Schreibvorgänge um und verhindert Disk-Flaschenhälse.