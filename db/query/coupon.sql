-- name: createCoupon :one
insert into coupons (code, description, coupon_type, amount, company_id, created_at)
values ($1, $2, $3, $4, $5, $6)
returning *;

-- name: getCoupon :one
select *
from coupons
where id = $1
  and deleted_at isnull
  and company_id = $2
limit 1;

-- name: getCoupons :many
select *
from coupons
where (coupon_type = sqlc.narg(coupon_type) or sqlc.narg(coupon_type) is null)
  and deleted_at isnull
  and company_id = $1
order by id;

-- name: updateCoupon :one
update coupons
set code        = coalesce(sqlc.narg(code), code),
    description = coalesce(sqlc.narg(description), description),
    coupon_type = coalesce(sqlc.narg(coupon_type), coupon_type),
    amount      = coalesce(sqlc.narg(amount), amount),
    updated_at  = $1
where id = $2
  and deleted_at isnull
  and company_id = $3
returning *;

-- name: deleteCoupon :one
update coupons
set deleted_at = now()
where id = $1
  and deleted_at isnull
  and company_id = $2
returning id;
