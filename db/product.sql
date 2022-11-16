-- name: createProduct :execresult
insert into products (name, description, cost, price, created_at, published_at, created_by_id)
values ($1, $2, $3, $4, $5, $6, $7);

-- name: getProduct :one
select *
from products
where id = $1
limit 1;

-- name: getProducts :many
select *
from products
where if(sqlc.narg(search) is null, true, (name regexp sqlc.narg(search) or description regexp sqlc.narg(search)))
order by $1;

-- name: updateProduct :execresult
update products
set name = coalesce(sqlc.narg(name), name),
    description = coalesce(sqlc.narg(description), description),
    cost = coalesce(sqlc.narg(cost), cost),
    price = coalesce(sqlc.narg(price), price),
    updated_at = $1,
    updated_by_id = coalesce(sqlc.narg(updated_by_id), id)
where id = $2;

-- name: deleteProduct :execresult
delete
from products
where id = $1;
