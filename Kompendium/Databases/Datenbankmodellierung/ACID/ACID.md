
## [[Atomicity]] / Atomizität 

Erklärung: Eine Transaktion besteht oft aus mehreren einzelnen Schritten oder Befehlen. Atomarität bedeutet, dass diese Schritte als eine unteilbare Einheit (ein „Atom“) behandelt werden. Entweder werden alle Schritte erfolgreich ausgeführt oder gar keiner.

Beispiel (Banküberweisung): Du überweist Geld von Konto A auf Konto B. Schritt 1: Geld von Konto A abziehen. Schritt 2: Geld dem Konto B gutschreiben. Bricht der Strom nach Schritt 1 ab, sorgt die Atomarität dafür, dass das abgezogene Geld nicht im Nichts verschwindet, sondern die gesamte Transaktion rückgängig gemacht wird (Rollback).

## [[Consistency]] / Konsistenz

Erklärung: Wenn mehrere Transaktionen gleichzeitig ablaufen, dürfen sie sich nicht gegenseitig stören oder unvollständige Zwischenzustände der jeweils anderen sehen. Jede Transaktion wird so ausgeführt, als wäre sie die einzige auf dem System.

Beispiel (Konzerttickets): Es gibt nur noch ein Ticket für ein Konzert. Du und eine andere Person klicken genau in derselben Sekunde auf „Jetzt kaufen“. Durch Isolation verarbeitet die Datenbank die Käufe nacheinander: Einer von euch bekommt das Ticket, und der andere erhält die Meldung, dass das Konzert ausverkauft ist – es wird niemals dasselbe Ticket an zwei Personen gleichzeitig verkauft.

## [[Isolation]] / Isolation

Erklärung: Sobald eine Transaktion erfolgreich abgeschlossen wurde (ein sogenannter Commit erfolgt ist), bleiben die Daten dauerhaft in der Datenbank gespeichert. Sie gehen selbst bei einem plötzlichen Stromausfall, Systemabsturz oder Hardwaredefekt nicht mehr verloren.

## [[Durability]] / Beständigkeit 

Beispiel (Systemabsturz): Du kaufst etwas online und erhältst die Bestätigung „Kauf erfolgreich“. Eine Millisekunde später stürzt der Server des Händlers komplett ab. Wenn der Server neu startet, ist dein Kauf trotzdem fest im System hinterlegt und ging nicht verloren