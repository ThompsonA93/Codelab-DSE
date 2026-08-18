Normalisierung ist der Prozess, bei dem eine relationale Datenbank so strukturiert wird, dass **Datenredundanzen (Dopplungen) minimiert** werden. 

Das Hauptziel ist es, sogenannte **Anomalien** zu vermeiden, die zu inkonsistenten Daten führen können:
- **Update-Anomalie:** Wenn sich z. B. eine Adresse ändert, muss sie an vielen Stellen gleichzeitig aktualisiert werden. Vergisst man eine, widersprechen sich die Daten.
- **Insert-Anomalie:** Man kann z. B. keinen neuen Kurs anlegen, solange noch kein Student dafür angemeldet ist.
- **Delete-Anomalie:** Löscht man den letzten Studenten eines Kurses, geht versehentlich auch die Information verloren, dass dieser Kurs überhaupt existiert.