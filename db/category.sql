-- name: createCategory :execresult
insert into categories (name, description, created_at, published_at, created_by_id)
values ($1, $2, $3, $4, $5);

-- name: getCategory :one
select id,
       name,
       description,
       created_at,
       updated_at,
       published_at,
       created_by_id,
       updated_by_id
from categories
where id = $1
limit 1;

-- name: getCategorys :many
select id,
       name,
       description,
       created_at,
       updated_at,
       published_at,
       created_by_id,
       updated_by_id
from categories
where if(sqlc.narg(search) is null, true, (name regexp sqlc.narg(search) or description regexp sqlc.narg(search)));

-- name: updateCategory :execresult
update categories
set name = coalesce(sqlc.narg(name), name),
    description = coalesce(sqlc.narg(description), description),
    updated_at = $1,
    updated_by_id = coalesce(sqlc.narg(updated_by_id), id)
where id = $2;

-- name: deleteCategory :execresult
delete
from categories
where id = $1;
