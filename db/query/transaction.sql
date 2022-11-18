-- name: createTransaction :one
insert into transactions (code, date, subtotal, discount, note, contact_id, company_id, transaction_type, created_at)
values ($1, $2, $3, $4, $5, $6, $7, $8, $9)
returning *;

-- name: createTransactionItem :one
insert into transaction_items (transaction_id, product_id, product_name, quantity, price, discount, note)
values ($1, $2, $3, $4, $5, $6, $7)
returning *;

-- name: createPayment :one
insert into payments (transaction_id, company_id, code, date, amount, note, created_at)
values ($1, $2, $3, $4, $5, $6, $7)
returning *;

-- name: getTransactions :many
select *
from transactions
where company_id = $1
  and (contact_id = sqlc.narg(contact_id) or sqlc.narg(contact_id) isnull)
  and (transaction_type = sqlc.narg(transaction_type) or sqlc.narg(transaction_type) isnull)
order by date desc;

-- name: getTransaction :one
select t.*,
       json_agg(ti.*) as items,
       json_agg(p.*)  as payments
from transactions t
left join transaction_items ti on t.id = ti.transaction_id
left join payments p on t.id = p.transaction_id
where t.id = $1
  and t.company_id = $2
group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11;

-- name: getPayments :many
select *
from payments
where company_id = $1;

-- name: getPayment :one
select *
from payments
where id = $1
  and company_id = $2;