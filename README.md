# Arkime Composer

A quick way to analyse PCAPs using Arkime.

## Setup

Edit `docker-compose.yml` to use the amd64 or arm64 version of elasticsearch.

```
docker-compose up -d
```

## Usage

Move PCAPs into the `./raw` directory and the `capture` container will parse them.

Access `http://localhost:8005` with credentials `admin:admin` to access the interface.

The time required to fully parse a PCAP will depend on the size of it.
