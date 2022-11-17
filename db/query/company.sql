-- name: createCompany :one
insert into companies (name, address, phone, email, created_at)
values ($1, $2, $3, $4, $5)
returning *;

-- name: createCompanyUserLink :exec
insert into up_users_companies_links (user_id, company_id, role)
values ($1, $2, $3);

-- name: getCompany :one
select *
from companies
where id = $1
  and deleted_at isnull
limit 1;

-- name: getCompanies :many
select *
from companies
where deleted_at isnull
order by name;

-- name: updateCompany :one
update companies
set name       = coalesce(sqlc.narg(name), name),
    address    = coalesce(sqlc.narg(address), address),
    phone      = coalesce(sqlc.narg(phone), phone),
    email      = coalesce(sqlc.narg(email), email),
    updated_at = $1
where id = $2
  and deleted_at isnull
returning *;

-- name: deleteCompany :one
update companies
set deleted_at = now()
where id = $1
  and deleted_at isnull
returning id;
