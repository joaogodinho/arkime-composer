# Arkime Composer

A quick way to analyse PCAPs using Arkime.

## Setup

```
docker-compose up -d
```

## Usage

Move PCAPs into the `./raw` directory and the `capture` container will parse them.

**In MacOS, it can happen that the `capture` does not get notified of changes in the `/opt/arkime/raw` folder. One needs to trigger a change inside the container. This can be done with:**

```
docker compose exec capture sh -c "touch /opt/arkime/raw/*"
```

Access `http://localhost:8005` with credentials `admin:admin` to access the interface.

The time required to fully parse a PCAP will depend on the size of it.
