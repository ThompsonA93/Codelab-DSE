## Was das ist, warum es besser ist als SQL und wie man es praxisnah einsetzt

# 1. Einführung: Was ist eine Zeitreihe?

Eine **Zeitreihe** ist eine Sammlung von Messwerten, die immer mit einem Zeitpunkt verbunden sind.

Beispiele:

- Temperaturmessungen eines Sensors
- Bitcoin-Kursverlauf
- CPU-Auslastung eines Servers
- Stromverbrauch eines Haushalts

## Eigenschaften einer Zeitreihe

### Append-Only

Messwerte werden normalerweise nicht nachträglich verändert.

Der typische Ablauf:

```
Neuer Messwert → Speichern → Später nur lesen/analysieren
```

Beispiel:

```
10:00 → Bitcoin 55.000 €
10:01 → Bitcoin 55.120 €
10:02 → Bitcoin 55.300 €
```

Es werden immer neue Daten angehängt.
## Der Zeitstempel ist entscheidend

Ein Wert alleine ist oft nutzlos.

Beispiel:

```
55462
```

Was bedeutet dieser Wert?

- Preis?
- Temperatur?
- Geschwindigkeit?

Erst der Zeitstempel macht ihn sinnvoll:

```
2026-08-18 13:00:00 → Bitcoin = 55462 €
```

Die Zeit ist deshalb der wichtigste Index einer Zeitreihendatenbank.
# Die 3 wichtigsten Begriffe in InfluxDB

## Measurement

Vergleichbar mit einer Tabelle in SQL.

Beispiel:

```
bitcoin
```
## Tag

Ein beschreibendes Label zum Filtern.

Tags werden automatisch indexiert.

Beispiel:

```
waehrung=EUR
```

Weitere Beispiele:

```
server=web01
region=europe
sensor=temperatur01
```
## Field

Der eigentliche Messwert, mit dem gerechnet wird.

Beispiel:

```
preis=55462.1
```

## Faustregel

> Wonach du filterst → Tag  
> Womit du rechnest → Field

Beispiel:

```
bitcoin,waehrung=EUR preis=55462.1
```

# 2. Warum brauche ich eine Zeitreihendatenbank?

## Vergleich: TSDB vs. SQL

| Problem | SQL-Datenbank | Zeitreihendatenbank |
|---|---|---|
| Millionen Messwerte | Wird langsamer durch Index-Updates | Für Massenschreiben optimiert |
| Zeitabfragen | Zusätzliche Logik nötig | Eingebaute Zeitfunktionen |
| Speicher | Größer | Komprimierte Speicherung |
| Alte Daten löschen | Manuell | Automatische Retention Policies |

## Extreme Schreiblast

Zeitreihendatenbanken sind für sehr viele Schreiboperationen optimiert.

Beispiel:

```
100.000 Messwerte pro Sekunde
```

Typische Anwendungen:

- IoT-Geräte
- Server-Monitoring
- Finanzdaten
- Sensordaten

## Spaltenartige Speicherung

Zeitreihendatenbanken können Daten stark komprimieren.

Beispiel:

```
100 GB Rohdaten
↓
10 GB Speicherbedarf
```

## Eingebaute Zeitfunktionen

Beispiele:

- Durchschnitt alle 5 Minuten
- Maximum pro Stunde
- Trends erkennen
- Zeiträume vergleichen

## Automatisches Aufräumen

Mit Retention Policies können alte Daten automatisch gelöscht werden.

Beispiel:

```
Speichere nur die letzten 30 Tage
```

# 3. Bekannte Zeitreihendatenbanken

## InfluxDB

Eine spezialisierte Zeitreihendatenbank.

Eigenschaften:

- eigene Datenstruktur
- eigene Abfragesprache Flux
- kein festes Schema
- sehr hohe Schreibgeschwindigkeit

Ideal für:

- Sensoren
- IoT
- Monitoring
- Geräte-Daten

## TimescaleDB

Eine Erweiterung für PostgreSQL.

Eigenschaften:

- normales SQL
- unterstützt Joins
- verbindet Messdaten mit relationalen Daten

Ideal für:

- Unternehmensanwendungen
- Kunden + Messdaten
- komplexe Datenmodelle

# 4. Setup: InfluxDB lokal installieren

## Variante A: Native Installation

Direkter Download und Installation.

Nachteile:

- mehr Konfiguration
- schwerer reproduzierbar

## Variante B: Docker (empfohlen)

Vorteile:

- schnell gestartet
- sauber getrennt
- einfach zu entfernen

## Variante C: Docker mit automatischem Setup

```bash
docker run -d --name influx \
  -p 8086:8086 \
  -v influx-data:/var/lib/influxdb2 \
  -e DOCKER_INFLUXDB_INIT_MODE=setup \
  -e DOCKER_INFLUXDB_INIT_USERNAME=admin \
  -e DOCKER_INFLUXDB_INIT_PASSWORD=geheimespasswort \
  -e DOCKER_INFLUXDB_INIT_ORG=Datenbank \
  -e DOCKER_INFLUXDB_INIT_BUCKET=krypto \
  -e DOCKER_INFLUXDB_INIT_ADMIN_TOKEN=mein-token \
  influxdb:2
```

Danach erreichbar unter:

```
http://localhost:8086
```

# 5. CRUD in einer TSDB

In SQL:

```
Create
Read
Update
Delete
```

sind alle Operationen gleich wichtig.

Bei Zeitreihendatenbanken ist die Gewichtung anders.

## Create (Schreiben)

Der wichtigste Vorgang.

Beispiele:

- neue Sensorwerte speichern
- Kurse speichern
- Logs speichern
## Read (Lesen)

Der zweite Hauptzweck.

Beispiele:

- Diagramme
- Statistiken
- Trends
## Update

Selten verwendet.

Warum?

Zeitreihendaten werden normalerweise nicht verändert.
## Delete

Meistens automatisch.

Beispiel:

```
Lösche Daten älter als 90 Tage
```

# 6. Die größten Pitfalls

## 1. Zu viele Tags (High Cardinality)

Falsch:

```
user_id=928374928374
```

oder:

```
uuid=7f8a9d...
```

Problem:

- hoher RAM-Verbrauch
- schlechte Performance

Besser:

```
waehrung=EUR
region=EU
server=web01
```

## 2. Falsche Datenstruktur

Falsch:

```
preis=55462
```

als Tag.

Warum?

Der Wert ändert sich ständig.

Richtig:

```
preis=55462.1
```

als Field.

## 3. Datentyp wechseln

Problem:

Erster Wert:

```
preis=55462
```

Integer

Später:

```
preis=55462.1
```

Float

Kann Fehler verursachen.

Lösung:

Immer direkt umwandeln:

```python
preis = float(preis)
```

# 7. Praxisbeispiel: Bitcoin Tracker

## Architektur

```
Kraken API
     |
     ↓
Python Script
     |
     ↓
InfluxDB
     |
     ↓
Dashboard / Data Explorer
```

## Ablauf

1. Python fragt Bitcoin-Kurs ab
2. Kurs wird verarbeitet
3. Daten werden gespeichert
4. Browser zeigt Live-Graph

# 8. Python Beispiel: Bitcoin speichern

```python
#!/usr/bin/env python3
"""
Bitcoin-Sammler fuer InfluxDB (schlanke Fassung)
=================================================

Holt den Bitcoin-Kurs in Euro von der oeffentlichen Kraken-API
und schreibt ihn in InfluxDB. Kein Account, kein API-Key noetig.

Gespeichert werden drei Werte:
    preis              Kurs in Euro
    aenderung          Veraenderung seit Tagesbeginn in Euro
    aenderung_prozent  Veraenderung seit Tagesbeginn in Prozent

Start:
    python bitcoin_sammler.py --dry-run    # nur anzeigen, nichts schreiben
    python bitcoin_sammler.py --once       # einmal schreiben
    python bitcoin_sammler.py              # laeuft dauerhaft

Beenden mit Strg+C.
"""

import argparse
import json
import os
import sys
import time
import urllib.request
import urllib.error

# ---------------------------------------------------------------------------
# EINSTELLUNGEN
# ---------------------------------------------------------------------------

INFLUX_URL    = os.environ.get("INFLUX_URL", "http://localhost:8086")
INFLUX_ORG    = os.environ.get("INFLUX_ORG", "Datenbank")
INFLUX_BUCKET = os.environ.get("INFLUX_BUCKET", "krypto")

# Token nicht hier eintragen, sondern vorher setzen:
#   $env:INFLUX_TOKEN = "dein-token"
INFLUX_TOKEN = os.environ.get("INFLUX_TOKEN", "")

# Sekunden zwischen zwei Abrufen. Unter 5 sperrt Kraken.
INTERVALL = int(os.environ.get("INTERVALL", "10"))

MEASUREMENT = "bitcoin"
API_URL = "https://api.kraken.com/0/public/Ticker?pair=XBTEUR"


# ---------------------------------------------------------------------------
# ZAHLEN DEUTSCH FORMATIEREN
# ---------------------------------------------------------------------------


def de(zahl, stellen=2, vorzeichen=False):
    """
    Formatiert eine Zahl deutsch: Punkt als Tausendertrenner, Komma als Komma.

        de(54662.1)              -> "54.662,10"
        de(0.6669, 3, True)      -> "+0,667"
        de(-362.1, 2, True)      -> "-362,10"
    """
    text = f"{abs(zahl):,.{stellen}f}"
    # Erst tauschen ueber einen Platzhalter, sonst ueberschreibt man sich selbst.
    text = text.replace(",", "#").replace(".", ",").replace("#", ".")
    if vorzeichen:
        return ("+" if zahl >= 0 else "-") + text
    return ("-" if zahl < 0 else "") + text


# ---------------------------------------------------------------------------
# KURS HOLEN
# ---------------------------------------------------------------------------


def kurs_holen():
    """
    Fragt Kraken und gibt (preis, aenderung_euro, aenderung_prozent) zurueck.

    Kraken antwortet so:
        {"error": [], "result": {"XXBTZEUR": {"c": ["54662.1", "0.001"], "o": "54300.0", ...}}}

    c = letzter gehandelter Kurs
    o = Kurs zu Tagesbeginn
    """
    request = urllib.request.Request(API_URL, headers={"User-Agent": "bitcoin-sammler/1.0"})
    with urllib.request.urlopen(request, timeout=20) as antwort:
        daten = json.loads(antwort.read().decode("utf-8"))

    if daten.get("error"):
        raise ValueError(f"Kraken meldet: {daten['error']}")

    # Der Schluessel heisst XXBTZEUR statt XBTEUR, deshalb einfach den
    # ersten Eintrag nehmen statt nach einem festen Namen zu suchen.
    werte = next(iter(daten["result"].values()))

    preis      = float(werte["c"][0])
    eroeffnung = float(werte["o"])

    aenderung_euro    = preis - eroeffnung
    aenderung_prozent = (aenderung_euro / eroeffnung * 100) if eroeffnung else 0.0

    # Genauer als die Anzeige, damit in der Datenbank nichts verloren geht.
    return preis, round(aenderung_euro, 4), round(aenderung_prozent, 4)


# ---------------------------------------------------------------------------
# SCHREIBEN
# ---------------------------------------------------------------------------


def zeile_bauen(preis, aenderung_euro, aenderung_prozent):
    """
    Baut eine Zeile im InfluxDB Line Protocol:

        bitcoin,waehrung=EUR preis=54662.1,aenderung=362.1,aenderung_prozent=0.6669 1787041960
        └──┬──┘ └─────┬────┘ └──────────────────────┬───────────────────────────┘ └────┬────┘
        Measurement   Tag                        Fields                          Zeitstempel

    float() ist wichtig: sonst legt InfluxDB beim ersten Schreiben den Typ
    Ganzzahl fest und lehnt spaeter jede Kommazahl ab.
    """
    zeitstempel = int(time.time())
    return (f"{MEASUREMENT},waehrung=EUR "
            f"preis={float(preis)},"
            f"aenderung={float(aenderung_euro)},"
            f"aenderung_prozent={float(aenderung_prozent)} "
            f"{zeitstempel}")


def in_influx_schreiben(zeile):
    """Schickt eine Zeile an InfluxDB."""
    if not INFLUX_TOKEN:
        raise RuntimeError('Kein Token gesetzt. Vorher:  $env:INFLUX_TOKEN = "dein-token"')

    url = (f"{INFLUX_URL}/api/v2/write"
           f"?org={INFLUX_ORG}&bucket={INFLUX_BUCKET}&precision=s")

    request = urllib.request.Request(
        url,
        data=zeile.encode("utf-8"),
        method="POST",
        headers={
            "Authorization": f"Token {INFLUX_TOKEN}",
            "Content-Type": "text/plain; charset=utf-8",
        },
    )

    try:
        with urllib.request.urlopen(request, timeout=20):
            return
    except urllib.error.HTTPError as fehler:
        details = fehler.read().decode("utf-8", errors="replace")
        raise RuntimeError(f"InfluxDB antwortete mit {fehler.code}: {details}") from None


# ---------------------------------------------------------------------------
# EIN DURCHGANG
# ---------------------------------------------------------------------------


def durchgang(dry_run=False):
    preis, aenderung_euro, aenderung_prozent = kurs_holen()
    zeile = zeile_bauen(preis, aenderung_euro, aenderung_prozent)

    pfeil = "hoch" if aenderung_euro > 0 else ("runter" if aenderung_euro < 0 else "gleich")

    print(f"  Kurs        {de(preis):>12} EUR")
    print(f"  Seit 0 Uhr  {de(aenderung_euro, 2, True):>12} EUR"
          f"   {de(aenderung_prozent, 3, True):>8} %   {pfeil}")

    if dry_run:
        print(f"\n  {zeile}")
        print("  (Testlauf, nichts geschrieben)")
        return

    in_influx_schreiben(zeile)


# ---------------------------------------------------------------------------
# START
# ---------------------------------------------------------------------------


def main():
    parser = argparse.ArgumentParser(description="Sammelt den Bitcoin-Kurs in InfluxDB.")
    parser.add_argument("--dry-run", action="store_true", help="Nur anzeigen, nichts schreiben.")
    parser.add_argument("--once", action="store_true", help="Nur einmal statt dauerhaft.")
    parser.add_argument("--intervall", type=int, default=INTERVALL,
                        help=f"Sekunden zwischen zwei Abrufen (Standard: {INTERVALL}).")
    args = parser.parse_args()

    if args.intervall < 5:
        args.intervall = 5

    print(f"Bitcoin-Sammler  ->  {INFLUX_URL}  Bucket '{INFLUX_BUCKET}'")
    print(f"Token: {'gesetzt' if INFLUX_TOKEN else 'FEHLT'}    Intervall: {args.intervall}s\n")

    if args.once or args.dry_run:
        durchgang(dry_run=args.dry_run)
        return

    print("Laeuft. Beenden mit Strg+C.\n")
    try:
        while True:
            print(f"[{time.strftime('%H:%M:%S')}]")
            try:
                durchgang()
            except Exception as fehler:
                # Ein Fehler soll den Sammler nicht beenden.
                print(f"  [Fehler] {fehler}", file=sys.stderr)
            time.sleep(args.intervall)
    except KeyboardInterrupt:
        print("\nBeendet.")


if __name__ == "__main__":
    main()
```
