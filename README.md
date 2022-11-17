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

- app.env file
```dotenv
MODULE=github.com/buatan/go-pos-umkm
ENV=staging
DB_DRIVER=postgresql
DB_NAME=posbuatan
DB_USER=posbuatan
DB_PASS=password
DB_HOST=localhost
DB_PORT=5432
```

- Create DB if not exist (only if you using local database)
```shell
make createdb
```

- Run db migration
```shell
make migrationup
```

- If you want to add new table
```shell
make newmigration-[DESC_example_add_users]
```

- If you done add migration query then run
```shell
make migrationup1
```

## Deployment

