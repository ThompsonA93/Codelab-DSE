```sql
-- Erstellt eine Funktion zur Bruttoberechnung
CREATE OR REPLACE FUNCTION fn_berechne_brutto(
    p_netto NUMERIC, 
    p_mwst NUMERIC DEFAULT 20.0
)
RETURNS NUMERIC -- Gibt einen einzelnen Zahlenwert (Skalar) zurück
LANGUAGE plpgsql -- Legt PL/pgSQL als Sprache fest
AS $$
BEGIN
    -- Direkte Rückgabe des berechneten Werts
    RETURN p_netto * (1 + p_mwst / 100.0);
END;
$$;

-- Aufruf in Obsidian/SQL:
SELECT fn_berechne_brutto(100.0, 20.0); -- Ergebnis: 120.0
```

```sql
-- Prüft den Rabattstatus eines Kunden basierend auf den Ausgaben
CREATE OR REPLACE FUNCTION fn_kunden_rabatt(p_kunden_id INT)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    -- Im DECLARE-Block werden Variablen mit Datentyp deklariert
    v_gesamtumsatz NUMERIC := 0.0;
    v_rabatt NUMERIC := 0.0;
BEGIN
    -- Liest den Umsatz aus einer Tabelle in die Variable v_gesamtumsatz
    SELECT COALESCE(SUM(betrag), 0) 
    INTO v_gesamtumsatz
    FROM bestellungen
    WHERE kunden_id = p_kunden_id;

    -- Kontrollstruktur zur Rabattermittlung
    IF v_gesamtumsatz > 5000 THEN
        v_rabatt := 15.0; -- 15% Rabatt
    ELSIF v_gesamtumsatz > 1000 THEN
        v_rabatt := 5.0;  -- 5% Rabatt
    ELSE
        v_rabatt := 0.0;  -- Kein Rabatt
    END IF;

    RETURN v_rabatt;
END;
$$;

-- Aufruf:
SELECT fn_kunden_rabatt(42);
```

```sql
-- Bereinigt alte Daten und führt dabei eine andere Routine aus
CREATE OR REPLACE FUNCTION fn_archiviere_alte_daten()
RETURNS VOID -- Funktion gibt keinen Wert zurück (reine Aktion)
LANGUAGE plpgsql
AS $$
BEGIN
    -- WICHTIG: PERFORM führt eine Abfrage/Routine aus und verwirft das Ergebnis.
    -- Ein normales SELECT würde in PL/pgSQL einen Syntaxfehler werfen!
    PERFORM fn_system_log('Bereinigung gestartet');

    -- Löscht alte Log-Einträge
    DELETE FROM system_logs 
    WHERE erstelldatum < NOW() - INTERVAL '1 year';

    -- Protokolliert das Ende
    PERFORM fn_system_log('Bereinigung abgeschlossen');
END;
$$;

-- Aufruf (mit SELECT oder CALL):
SELECT fn_archiviere_alte_daten();
```

```sql

-- Gibt alle Produkte einer bestimmten Kategorie als Tabelle zurück
CREATE OR REPLACE FUNCTION fn_get_produkte_nach_kategorie(p_kategorie_id INT)
RETURNS TABLE (
    produkt_id INT,
    produkt_name TEXT,
    preis NUMERIC
) -- Definiert die Spaltenstruktur der Ergebnismenge (SRF)
LANGUAGE plpgsql
AS $$
BEGIN
    -- RETURN QUERY gibt das Resultat eines kompletten SELECT-Statements zurück
    RETURN QUERY
    SELECT 
        p.id, 
        p.name, 
        p.preis
    FROM produkte p
    WHERE p.kategorie_id = p_kategorie_id
    ORDER BY p.preis DESC;
END;
$$;

-- Aufruf wie bei einer normalen Tabelle:
SELECT * FROM fn_get_produkte_nach_kategorie(3);
```

```sql

-- Generiert eine Zahlenreihe mit Quadratzahlen (Zeile für Zeile)
CREATE OR REPLACE FUNCTION fn_generiere_quadrat_tabelle(p_max INT)
RETURNS TABLE (
    zahl INT,
    quadrat INT
) -- Gibt eine Tabelle zeilenweise zurück
LANGUAGE plpgsql
AS $$
DECLARE
    v_i INT := 1; -- Laufvariable für die Schleife
BEGIN
    -- Schleife von 1 bis p_max
    WHILE v_i <= p_max LOOP
        -- Zuweisung der Werte für die Ausgabespalten
        zahl := v_i;
        quadrat := v_i * v_i;
        
        -- RETURN NEXT hängt die aktuelle Zeile an die Ergebnismenge an
        RETURN NEXT; 

        v_i := v_i + 1; -- Inkrement
    END LOOP;

    -- Signalisiert das Ende der Schleife/Funktion
    RETURN;
END;
$$;

-- Aufruf:
SELECT * FROM fn_generiere_quadrat_tabelle(5);
```