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

