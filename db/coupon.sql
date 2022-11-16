-- name: createCoupon :execresult
insert into coupons (code, description, type, amount, created_at, published_at, created_by_id)
values ($1, $2, $3, $4, $5, $6, $7);

-- name: getCoupon :one
select *
from coupons
where id = $1
limit 1;

-- name: getCoupons :many
select id,
       code,
       description,
       type,
       amount,
       created_at,
       updated_at,
       published_at,
       created_by_id,
       updated_by_id
from coupons
where if(sqlc.narg(type) is null, true, type = sqlc.narg(type))
and if(sqlc.narg(search) is null, true, (code regexp sqlc.narg(search) or description regexp sqlc.narg(search)))
order by $1;

-- name: updateCoupon :execresult
update coupons
set code = coalesce(sqlc.narg(code), code),
    description = coalesce(sqlc.narg(description), description),
    type = coalesce(sqlc.narg(type), type),
    amount = coalesce(sqlc.narg(amount), amount),
    updated_at = $1,
    updated_by_id = coalesce(sqlc.narg(updated_by_id), id)
where id = $2;

-- name: deleteCoupon :execresult
delete
from coupons
where id = $1;
