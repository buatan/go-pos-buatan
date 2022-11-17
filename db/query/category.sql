-- name: createCategory :one
insert into categories (name, description, company_id, created_at)
values ($1, $2, $3, $4)
returning *;

-- name: getCategory :one
select *
from categories
where id = $1
limit 1;

-- name: getCategories :many
select *
from categories;

-- name: updateCategory :one
update categories
set name = coalesce(sqlc.narg(name), name),
    description = coalesce(sqlc.narg(description), description),
    updated_at = $1
where id = $2
returning *;

-- name: deleteCategory :one
delete
from categories
where id = $1
returning id;
