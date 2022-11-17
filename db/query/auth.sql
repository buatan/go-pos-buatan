-- name: getUserByIdentifier :one
select *
from up_users
where (username = @identifier or email = @identifier)
  and deleted_at isnull;

-- name: updateResetPasswordToken :one
update up_users
set reset_password_token = $1,
    updated_at           = $2
where email = $3
  and deleted_at isnull
returning *;

-- name: resetPassword :one
update up_users
set password   = $1,
    updated_at = $2
where reset_password_token = $3
  and deleted_at isnull
returning *;

-- name: confirmEmail :one
update up_users
set confirmed  = true,
    updated_at = $1
where confirmation_token = $2
  and deleted_at isnull
returning *;