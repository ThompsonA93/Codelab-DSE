### Definition

Ein Hash-Index ist eine Indexstruktur in Datenbanken, die auf einer Hashfunktion basiert, statt auf einem sortierten Baum ([[B-Tree]]-Index).

Der Wert der indizierten Spalte wird durch eine Hashfunktion in einen Hashwert umgerechnet. Dieser bestimmt den Bucket, in dem der Verweis auf die Tabellenzeile gespeichert wird. Bei einer Suche wird der Suchwert gehasht und der Bucket direkt angesprungen – dadurch ist die Suche im Idealfall in konstanter Zeit O(1) möglich.
#### Stärken

- Sehr schnell bei Gleichheitsabfragen
	- z.B.: ``` WHERE email = 'x@y.at' ```

#### Schwächen

- Keine Bereichsabfragen möglich
	- z.B.: 
		- ``` WHERE preis > 100 ```
		- ``` BETWEEN ```
		- ``` LIKE 'ab%' ```
- Hashwerte haben keine Ordnung, ähnliche Werte landen in völlig verschiedenen Buckets
- Kein sortiertes Auslesen (```ORDER BY```)
- Hash-Kollisionen (zwei Werte, gleicher Hash) müssen aufgelöst werden, z.B. durch Verkettung im Bucket
- Bei vielen Kollisionen oder vollen Buckets muss die Hashtabelle vergrößert und neu verteilt werden (Rehashing).

##### Bucket

Ein (Hash-)Bucket  ist eine Art "Behälter" bzw. Speicherplatz innerhalb der Hashtabelle, in dem die Einträge landen.

Eine Hashtabelle ist so ähnlich wie ein Array -> nummerierte Fächer. 
Jedes Fach ist ein Bucket.
Die Hashfunktion berechnet aus dem Schlüsselwert (z.B. email) eine Nummer, und diese Nummer bestimmt, in welches Fach der Eintrag kommt. 

```
hash('x@y.at') ->  7 -> Bucket  7
hash('a@b.de') -> 23 -> Bucket 23
```
In einem Bucket selbst steht der Verweis auf z.B. die Zeilen-ID bzw. den Speicherort. Bei Kollisionen kann ein Bucket mehrere Einträge enthalten, die z. B. als verkettete Liste abgelegt werden.