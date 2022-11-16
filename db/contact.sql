-- name: createContact :execresult
insert into contacts (name, phone, email, address, bank_account, type, created_at, published_at,
                      created_by_id)
values ($1, $2, $3, $4, $5, $6, $7, $8, $9);

-- name: getContact :one
select id,
       name,
       phone,
       email,
       address,
       bank_account,
       type,
       created_at,
       updated_at,
       published_at,
       created_by_id,
       updated_by_id
from contacts
where id = $1;

-- name: getContacts :many
select id,
       name,
       phone,
       email,
       address,
       bank_account,
       type,
       created_at,
       updated_at,
       published_at,
       created_by_id,
       updated_by_id
from contacts
where if(sqlc.narg(type) is null, true, type = sqlc.narg(type))
  and if(sqlc.narg(search) is null, true,
         (name regexp sqlc.narg(search) or phone regexp sqlc.narg(search) or email regexp sqlc.narg(search) or
          address regexp sqlc.narg(search) or bank_account regexp sqlc.narg(search)))
order by $1;

-- name: updateContact :execresult
update contacts
set name = coalesce(sqlc.narg(name), name),
    phone = coalesce(sqlc.narg(phone), phone),
    email = coalesce(sqlc.narg(email), email),
    address = coalesce(sqlc.narg(address), address),
    bank_account = coalesce(sqlc.narg(bank_account), bank_account),
    type = coalesce(sqlc.narg(type), type),
    updated_at = $1,
    updated_by_id = coalesce(sqlc.narg(updated_by_id), id)
where id = $2;

-- name: deleteContact :execresult
delete
from contacts
where id = $1;
