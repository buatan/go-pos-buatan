-- name: createProduct :one
insert into products (name, description, cost, price, company_id)
values ($1, $2, $3, $4, $5)
returning *;

-- name: createProductCategoryLink :exec
insert into products_categories_links (category_id, product_id)
values ($1, $2);

-- name: getProduct :one
select *
from products
where id = $1
limit 1;

-- name: getProducts :many
select *
from products
order by id;

-- name: updateProduct :one
update products
set name = coalesce(sqlc.narg(name), name),
    description = coalesce(sqlc.narg(description), description),
    cost = coalesce(sqlc.narg(cost), cost),
    price = coalesce(sqlc.narg(price), price),
    updated_at = $1
where id = $2
returning *;

-- name: deleteProduct :one
delete
from products
where id = $1
returning id;
