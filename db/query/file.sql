-- name: createFile :one
insert into files (name, url, file_type, company_id, created_at)
values ($1, $2, $3, $4, $5)
returning *;

-- name: getFile :one
select *
from files
where id = $1
and deleted_at isnull
and company_id = $2;

-- name: getFiles :many
select *
from files
where deleted_at isnull
and company_id = $1
order by id;

-- name: deleteFile :one
update files
set deleted_at = now()
where id = $1
and deleted_at isnull
and company_id = $2
returning id;