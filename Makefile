include app.env

createdb:
	docker-compose --env-file app.env up db -d

dropdb:
	docker-compose down

newmigration-%:
	migrate create -ext sql -dir db/migration -seq $(*)

migration-%:
	migrate -path db/migration -database "$(DB_DRIVER)://$(DB_USER):$(DB_PASS)@$(DB_HOST):$(DB_PORT)/$(DB_NAME)" -verbose $(*) $(single)

migrationup:
	make migration-up

migratedown:
	make migration-down

migratedrop:
	make migration-drop

migrationup1:
	single=1 make migration-up

migrationdown1:
	single=1 make migration-down

sqlc:
	sqlc generate

.PHONY: createdb dropdb migrationup migratedown migrationup1 migrationdown1 sqlc
