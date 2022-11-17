-- name: createCategory :one
insert into categories (name, description, company_id, created_at)
values ($1, $2, $3, $4)
returning *;

-- name: getCategory :one
select *
from categories
where id = $1
  and deleted_at isnull
  and company_id = $2
limit 1;

-- name: getCategories :many
select *
from categories
where deleted_at isnull
  and company_id = $1;

-- name: updateCategory :one
update categories
set name        = coalesce(sqlc.narg(name), name),
    description = coalesce(sqlc.narg(description), description),
    updated_at  = $1
where id = $2
  and deleted_at isnull
  and company_id = $3
returning *;

-- name: deleteCategory :one
update categories
set deleted_at = now()
where id = $1
  and deleted_at isnull
  and company_id = $2
returning id;
