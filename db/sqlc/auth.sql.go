// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.16.0
// source: auth.sql

package db

import (
	"context"
	"database/sql"
)

const confirmEmail = `-- name: confirmEmail :one
update up_users
set confirmed  = true,
    updated_at = $1
where confirmation_token = $2
  and updated_at is not null
returning id, name, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, deleted_at
`

type confirmEmailParams struct {
	UpdatedAt         sql.NullTime `json:"updated_at"`
	ConfirmationToken string       `json:"confirmation_token"`
}

func (q *Queries) confirmEmail(ctx context.Context, arg confirmEmailParams) (UpUser, error) {
	row := q.db.QueryRowContext(ctx, confirmEmail, arg.UpdatedAt, arg.ConfirmationToken)
	var i UpUser
	err := row.Scan(
		&i.ID,
		&i.Name,
		&i.Username,
		&i.Email,
		&i.Provider,
		&i.Password,
		&i.ResetPasswordToken,
		&i.ConfirmationToken,
		&i.Confirmed,
		&i.Blocked,
		&i.CreatedAt,
		&i.UpdatedAt,
		&i.DeletedAt,
	)
	return i, err
}

const getUserByIdentifier = `-- name: getUserByIdentifier :one
select id, name, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, deleted_at
from up_users
where (username = $1 or email = $1)
  and updated_at is not null
`

func (q *Queries) getUserByIdentifier(ctx context.Context, identifier string) (UpUser, error) {
	row := q.db.QueryRowContext(ctx, getUserByIdentifier, identifier)
	var i UpUser
	err := row.Scan(
		&i.ID,
		&i.Name,
		&i.Username,
		&i.Email,
		&i.Provider,
		&i.Password,
		&i.ResetPasswordToken,
		&i.ConfirmationToken,
		&i.Confirmed,
		&i.Blocked,
		&i.CreatedAt,
		&i.UpdatedAt,
		&i.DeletedAt,
	)
	return i, err
}

const resetPassword = `-- name: resetPassword :one
update up_users
set password   = $1,
    updated_at = $2
where reset_password_token = $3
  and updated_at is not null
returning id, name, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, deleted_at
`

type resetPasswordParams struct {
	Password           string         `json:"password"`
	UpdatedAt          sql.NullTime   `json:"updated_at"`
	ResetPasswordToken sql.NullString `json:"reset_password_token"`
}

func (q *Queries) resetPassword(ctx context.Context, arg resetPasswordParams) (UpUser, error) {
	row := q.db.QueryRowContext(ctx, resetPassword, arg.Password, arg.UpdatedAt, arg.ResetPasswordToken)
	var i UpUser
	err := row.Scan(
		&i.ID,
		&i.Name,
		&i.Username,
		&i.Email,
		&i.Provider,
		&i.Password,
		&i.ResetPasswordToken,
		&i.ConfirmationToken,
		&i.Confirmed,
		&i.Blocked,
		&i.CreatedAt,
		&i.UpdatedAt,
		&i.DeletedAt,
	)
	return i, err
}

const updateResetPasswordToken = `-- name: updateResetPasswordToken :one
update up_users
set reset_password_token = $1,
    updated_at           = $2
where email = $3
  and updated_at is not null
returning id, name, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, deleted_at
`

type updateResetPasswordTokenParams struct {
	ResetPasswordToken sql.NullString `json:"reset_password_token"`
	UpdatedAt          sql.NullTime   `json:"updated_at"`
	Email              string         `json:"email"`
}

func (q *Queries) updateResetPasswordToken(ctx context.Context, arg updateResetPasswordTokenParams) (UpUser, error) {
	row := q.db.QueryRowContext(ctx, updateResetPasswordToken, arg.ResetPasswordToken, arg.UpdatedAt, arg.Email)
	var i UpUser
	err := row.Scan(
		&i.ID,
		&i.Name,
		&i.Username,
		&i.Email,
		&i.Provider,
		&i.Password,
		&i.ResetPasswordToken,
		&i.ConfirmationToken,
		&i.Confirmed,
		&i.Blocked,
		&i.CreatedAt,
		&i.UpdatedAt,
		&i.DeletedAt,
	)
	return i, err
}
