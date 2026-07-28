Constraints (Integritätsbedingungen) sichern die Datenqualität direkt auf Datenbankebene.

Die Anwendung muss sich nicht darauf verlassen, dass jede Query korrekt ist. Verletzt ein `INSERT` oder `UPDATE` eine Regel, lehnt die Datenbank den Vorgang ab.

Typische Constraints in PostgreSQL:

#### [[NOT NULL]]

#### [[UNIQUE]]

#### [[CHECK]]

Zusätzlich gehören [[Primärschlüssel]] und [[Fremdschlüssel]] zu den zentralen Integritätsregeln — sie werden unter [[Integrität]] behandelt.
