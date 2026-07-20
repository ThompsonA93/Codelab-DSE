# Kompendium

Dieses Kompendium ist mit [Obsidian](https://obsidian.md/) kompatibel oder kann auch ohne dieses Programm verwendet werden.

Öffne den Ordner als neuen Vault oder mit einem Editor deiner Wahl.

## Roadmap

#### 1. [[Datenbanken]] 

Der Kernpunkt einer jeden Software - Die Daten- oder Persistenzschicht. Hier lagern alle Informationen welche für eine Applikation lebenswichtig sind, unabhängig vom Typ der Daten. 
Anfragen von Daten kommen in unterschiedlichsten Formen, und den Fluss dieser Daten kann man sich ungefähr so veranschaulichen: 

```
  Applikation   |   Persistenz
  --------------+--------------
1. Anfrage  ->  |  -> Datenbank  ->  Tabellen  ->  Einträge
				|									  v
2. Antwort  <-  |  <- Datenbank  <-  Tabellen  <-  Einträge
```

Folgende Fakten sind wesentliche Ziele zum kennenlernen:
- Das wichtigste zu Wissen ist, welches Werkzeug für welchen Zweck verwendet werden soll.
  Simple, relationale Daten sind leichter zu handhaben als wie z.B. Bilddateien oder hierarchische Datenstrukturen.
- Die Informationsspeicher sind die innersten Kerne einer jeden Applikation. Muss man diese verändern, so muss sich auch alles verändern was davon abhängt. Ein frühes, gutes Design erspart später viel Nacharbeit.
- Es gibt unterschiedliche Designmuster um Datenbankzugriffe zu gestalten, und dies lässt sich bereits in der Persistenz programmieren.

#### 2. [[Software-Entwicklung]]

Die Software-Entwicklung in diesem Kontext beschreibt die serverseitige Entwicklung und kann entweder auf Kommunikation zwischen Maschine und Maschine abzielen, oder auf Mensch und Maschine. In beiden Fällen muss die Software jedoch viele unterschiedliche Anforderungen gerecht werden.


- Ohne korrekter Kopplung bestehender Systeme ist die Software unbrauchbar. Daher verwendet man für diesen Zweck vorbestimmte Verträge zwischen Systemen in Form von verallgemeinerten Programmierkomponenten.
- Die einfache Bedienbarkeit für Anwender, egal ob für Systemadministrator oder Social-Media-Influencer, bestimmt ultimativ ob die entwickelte Software tatsächlich genutzt oder gekauft wird. Ein ebenso wichtiger Aspekt ist, wie barrierefrei die Software genutzt werden kann.
- Die Systemsicherheit und nationale, sowie internationale, rechtliche Vorlagen können eine immense Hürde darstellen. Hierzu sollte man umfassendes Testen und Validieren der Software anstreben.

