-- name: createUser :one
insert into up_users (username,
                      email,
                      provider,
                      password,
                      reset_password_token,
                      confirmation_token,
                      confirmed,
                      blocked,
                      name,
                      created_at)
values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
returning *;

-- name: getUser :one
select *
from up_users
where id = $1
  and deleted_at isnull
limit 1;

-- name: getUsers :many
select *
from up_users
where (provider = sqlc.narg(provider) or sqlc.narg(provider) isnull)
  and (confirmed = sqlc.narg(confirmed) or sqlc.narg(confirmed) isnull)
  and (blocked = sqlc.narg(blocked) or sqlc.narg(blocked) isnull)
  and deleted_at isnull
order by id desc
limit $1 offset $2;

-- name: countUsers :one
select count(*) as total
from up_users
where (provider = sqlc.narg(provider) or sqlc.narg(provider) isnull)
  and (confirmed = sqlc.narg(confirmed) or sqlc.narg(confirmed) isnull)
  and (blocked = sqlc.narg(blocked) or sqlc.narg(blocked) isnull)
  and deleted_at isnull;

-- name: updateUser :one
update up_users
set email                = coalesce(sqlc.narg(email), email),
    password             = coalesce(sqlc.narg(password), password),
    reset_password_token = coalesce(sqlc.narg(reset_password_token), reset_password_token),
    confirmed            = coalesce(sqlc.narg(confirmed), confirmed),
    blocked              = coalesce(sqlc.narg(blocked), blocked),
    name                 = coalesce(sqlc.narg(name), name),
    updated_at           = sqlc.arg(updated_at)
where id = $1
  and deleted_at isnull
returning *;

-- name: deleteUser :one
update up_users
set deleted_at = now()
where id = $1
  and deleted_at isnull
returning id;
