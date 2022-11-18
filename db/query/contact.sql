-- name: createContact :one
insert into contacts (name, phone, email, address, bank_account, contact_type, balance, company_id, created_at)
values ($1, $2, $3, $4, $5, $6, $7, $8, $9)
returning *;

-- name: getContact :one
select *
from contacts
where id = $1
  and deleted_at isnull
  and company_id = $2;

-- name: getContacts :many
select *
from contacts
where (contact_type = sqlc.narg(contact_type) or sqlc.narg(contact_type) isnull)
  and deleted_at = $1
  and company_id = $2
order by id;

-- name: updateContact :one
update contacts
set name         = coalesce(sqlc.narg(name), name),
    phone        = coalesce(sqlc.narg(phone), phone),
    email        = coalesce(sqlc.narg(email), email),
    address      = coalesce(sqlc.narg(address), address),
    bank_account = coalesce(sqlc.narg(bank_account), bank_account),
    contact_type = coalesce(sqlc.narg(contact_type), contact_type),
    updated_at   = $1
where id = $2
  and deleted_at isnull
  and company_id = $3
returning *;

-- name: deleteContact :one
update contacts
set deleted_at = now()
where id = $1
  and deleted_at isnull
  and company_id = $2
returning id;
