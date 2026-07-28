
## [[Entity-Relationship Diagramme]]#

## [[Kardinalitäten]]

## [[Integrität]]
## [[Joins]]

## [[ACID]]

## [[Normalisierung]]

Normalisierung ist der Prozess, bei dem eine relationale Datenbank so strukturiert wird, dass **Datenredundanzen (Dopplungen) minimiert** werden. 

Das Hauptziel ist es, sogenannte **Anomalien** zu vermeiden, die zu inkonsistenten Daten führen können:
- **Update-Anomalie:** Wenn sich z. B. eine Adresse ändert, muss sie an vielen Stellen gleichzeitig aktualisiert werden. Vergisst man eine, widersprechen sich die Daten.
- **Insert-Anomalie:** Man kann z. B. keinen neuen Kurs anlegen, solange noch kein Student dafür angemeldet ist.
- **Delete-Anomalie:** Löscht man den letzten Studenten eines Kurses, geht versehentlich auch die Information verloren, dass dieser Kurs überhaupt existiert.
## 1. Normalform (1NF)

**Regel:** Jeder Wert in einer Zelle muss **atomar** (unteilbar) sein.
Das bedeutet: Keine Listen, keine kommagetrennten Werte und keine Aufzählungen in einer einzigen Tabellenzelle. Jede Zelle darf nur genau eine Information enthalten.

**Falsch (Nicht in 1NF):**

| Kunden_ID | Name         | Gekaufte_Artikel |
| --------- | ------------ | ---------------- |
| 1         | Anna Schmidt | Apfel, Birne     |

**Richtig (In 1NF):**
Wir trennen Vor- und Nachnamen (da "Anna Schmidt" teilbar ist) und legen für jeden Artikel eine neue Zeile an.

| Kunden_ID | Vorname | Nachname | Artikel |
| --------- | ------- | -------- | ------- |
| 1         | Anna    | Schmidt  | Apfel   |
| 1         | Anna    | Schmidt  | Birne   |
## 2. Normalform (2NF)

**Regel:** Die 1NF ist erfüllt **UND** jedes Nicht-Schlüssel-Attribut ist *vollständig* vom gesamten Primärschlüssel abhängig.
Das betrifft nur Tabellen, die einen **zusammengesetzten Primärschlüssel** haben (ein Schlüssel, der aus mehr als einer Spalte besteht). Kein Attribut darf nur von einem *Teil* des Schlüssels abhängen (partielle Abhängigkeit).

**Falsch (Nicht in 2NF):**
*Primärschlüssel ist hier die Kombination aus: `Studenten_ID` + `Kurs_ID`*

| Studenten_ID | Kurs_ID | Kursname | Note |
| ------------ | ------- | -------- | ---- |
| 1            | 101     | Mathe 1  | 1.3  |
|              |         |          |      |
Das Problem: Der `Kursname` (Mathe 1) hängt nur von der `Kurs_ID` ab, nicht von der `Studenten_ID`. Wenn sich der Kursname ändert, müssten wir das bei jedem Studenten ändern.

**Richtig (In 2NF):**
Wir teilen das in zwei Tabellen auf.

**Tabelle: Kurse**

| Kurs_ID | Kursname |
| ------- | -------- |
| 101     | Mathe 1  |

**Tabelle: Noten_Historie** *(Primärschlüssel: Studenten_ID + Kurs_ID)*

| Studenten_ID | Kurs_ID | Note |
| ------------ | ------- | ---- |
| 1            | 101     | 1.3  |
## 3. Normalform (3NF)

**Regel:** Die 2NF ist erfüllt **UND** es gibt keine *transitiven* Abhängigkeiten.
Das bedeutet: Ein Nicht-Schlüssel-Attribut darf **nicht** von einem anderen Nicht-Schlüssel-Attribut abhängen. Alles muss direkt vom Primärschlüssel abhängen.

**Falsch (Nicht in 3NF):**
*Primärschlüssel: `Mitarbeiter_ID`*

| Mitarbeiter_ID | Name | Abteilung | Abteilungsleiter |
| -------------- | ---- | --------- | ---------------- |
| 1              | Max  | IT        | Herr Müller      |

Das Problem: Der `Abteilungsleiter` hängt in Wirklichkeit von der `Abteilung` ab, und die Abteilung erst vom Mitarbeiter. (Mitarbeiter -> Abteilung -> Abteilungsleiter). Wenn Herr Müller kündigt, müssen wir ihn bei *jedem* IT-Mitarbeiter austauschen.

**Richtig (In 3NF):**
Wir lagern die Abteilungs-Infos aus.

**Tabelle: Mitarbeiter**

| Mitarbeiter_ID | Name | Abteilung_ID |
| -------------- | ---- | ------------ |
| 1              | Max  | 10           |
**Tabelle: Abteilungen**

| Abteilung_ID | Abteilung | Abteilungsleiter |
| ------------ | --------- | ---------------- |
| 10           | IT        | Herr Müller      |
