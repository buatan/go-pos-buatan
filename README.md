# POS Buatan

![POS UMKM](logo.png)

RESTful API untuk aplikasi Point of Sales UMKM

## Stack & Tools

- [SQLC](https://docs.sqlc.dev/en/latest/overview/install.html)
- [Golang Migrate](https://github.com/golang-migrate/migrate/tree/master/cmd/migrate)
- [DB Diagram](https://dbdiagram.io/home)
- [DBeaver](https://dbeaver.io/download/)
- [Docker](https://www.docker.com/)
- [MariaDB](https://hub.docker.com/_/mariadb)

## Development

- Creating schema
```shell
migrate create -ext sql -dir db/migration -seq init_schema
```

## Deployment

