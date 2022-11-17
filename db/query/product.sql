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
  and deleted_at isnull
  and company_id = $2
limit 1;

-- name: getProducts :many
select *
from products
where deleted_at isnull
  and company_id = $1
order by id;

-- name: updateProduct :one
update products
set name        = coalesce(sqlc.narg(name), name),
    description = coalesce(sqlc.narg(description), description),
    cost        = coalesce(sqlc.narg(cost), cost),
    price       = coalesce(sqlc.narg(price), price),
    updated_at  = $1
where id = $2
  and deleted_at isnull
  and company_id = $3
returning *;

-- name: deleteProduct :one
update products
set deleted_at = now()
where id = $1
  and deleted_at isnull
  and company_id = $2
returning id;
