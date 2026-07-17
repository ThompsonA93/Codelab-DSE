
> https://www.docker.com/products/docker-desktop/ 

Docker ist eine Softwareplattform, mit der Anwendungen und alle ihre benötigten Abhängigkeiten in sogenannte Container verpackt werden. Dadurch läuft die Software auf jedem Computer, egal ob auf dem eigenen Laptop, auf einem Server im Unternehmen oder in der Cloud, immer genau gleich.

## Docker-CLI

Sobald Docker am Rechner installiert ist, kann man mithilfe einer Shell die `Docker` befehle ausführen.

Um Postgres mithilfe der CLI zu starten, bedarf es zweier Befehle.

```sh
~$ docker volume create pg_data_volume  # Erstellt Volumes für den Container

~$ docker run --name local-postgres `
  -e POSTGRES_PASSWORD=my_secure_password `
  -v pg_data_volume:/var/lib/postgresql/data `
  -p 5432:5432 `
  -d postgres:17 # Startet die Container-Instanz mithilfe dieser Flags
```

Um mit der Datenbank über CLI zu interagieren, kann man folgenden Befehl ausführen.

```sh
~$ docker exec -it local-postgres psql -U postgres
```

## Dockerfile

Ein Dockerfile ist eine lokale Datei mit Konfigurationen für Docker. Man kann neben der Instanzierung des Containers weitere Skripte ausführen lassen, um z.B. das Datenbanksetup automatisch zu vervollständigen.

1. Erstelle ein File namens "Dockerfile"
2. Editiere dieses mit folgendem Beispiel:
```Dockerfile
FROM postgres:17

ENV POSTGRES_DB=app_db
ENV POSTGRES_USER=app_admin
ENV POSTGRES_PASSWORD=super_secure_password

COPY init.sql /docker-entrypoint-initdb.d/
```
3. Baue das Abbild des Dockerfiles
```sh
~$ docker build -t my-postgres .   
```
4. Starte einen Container anhand des Abbildes.
```sh
docker run --name my-postgres `
  -v pg_custom_data:/var/lib/postgresql/data `
  -p 5432:5432 `
  -d my-custom-postgres
```

Ähnlich wie oben, kann man mit `docker exec` eine interaktive Sitzung mit der Datenbank im Container starten.

## Docker Compose

Docker Compose ist die gängigste Art Docker zu verwenden. Diese gilt als lokales Orchestrierungstool von Docker, d.h. man kann in einem Skript genannt `compose.yaml` multiple Container aufsetzen und weitere Skripte ausführen lassen.

1. Erstelle ein File namens `compose.yaml`
2. Editiere dieses mit folgendem Beispiel:
```yaml
services:
  database:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: compose-pg-container
    environment:
      - POSTGRES_DB=app_db
      - POSTGRES_USER=app_admin
      - POSTGRES_PASSWORD=super_secure_password
    ports:
      - "5432:5432"
    volumes:
      - pg_compose_data:/var/lib/postgresql
    restart: unless-stopped

volumes:
  pg_compose_data:
```
3. Starte den Compose-Stack
```sh
docker compose up -d
```