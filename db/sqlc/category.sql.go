// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.15.0
// source: category.sql

package db

import (
	"context"
	"database/sql"
	"time"
)

const createCategory = `-- name: createCategory :one
insert into categories (name, description, company_id, created_at)
values ($1, $2, $3, $4)
returning id, name, description, company_id, created_at, updated_at, deleted_at
`

type createCategoryParams struct {
	Name        string         `json:"name"`
	Description sql.NullString `json:"description"`
	CompanyID   int64          `json:"company_id"`
	CreatedAt   time.Time      `json:"created_at"`
}

func (q *Queries) createCategory(ctx context.Context, arg createCategoryParams) (Category, error) {
	row := q.db.QueryRowContext(ctx, createCategory,
		arg.Name,
		arg.Description,
		arg.CompanyID,
		arg.CreatedAt,
	)
	var i Category
	err := row.Scan(
		&i.ID,
		&i.Name,
		&i.Description,
		&i.CompanyID,
		&i.CreatedAt,
		&i.UpdatedAt,
		&i.DeletedAt,
	)
	return i, err
}

const deleteCategory = `-- name: deleteCategory :one
update categories
set deleted_at = now()
where id = $1
  and deleted_at isnull
  and company_id = $2
returning id
`

type deleteCategoryParams struct {
	ID        int64 `json:"id"`
	CompanyID int64 `json:"company_id"`
}

func (q *Queries) deleteCategory(ctx context.Context, arg deleteCategoryParams) (int64, error) {
	row := q.db.QueryRowContext(ctx, deleteCategory, arg.ID, arg.CompanyID)
	var id int64
	err := row.Scan(&id)
	return id, err
}

const getCategories = `-- name: getCategories :many
select id, name, description, company_id, created_at, updated_at, deleted_at
from categories
where deleted_at isnull
  and company_id = $1
`

func (q *Queries) getCategories(ctx context.Context, companyID int64) ([]Category, error) {
	rows, err := q.db.QueryContext(ctx, getCategories, companyID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var items []Category
	for rows.Next() {
		var i Category
		if err := rows.Scan(
			&i.ID,
			&i.Name,
			&i.Description,
			&i.CompanyID,
			&i.CreatedAt,
			&i.UpdatedAt,
			&i.DeletedAt,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Close(); err != nil {
		return nil, err
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}

const getCategory = `-- name: getCategory :one
select id, name, description, company_id, created_at, updated_at, deleted_at
from categories
where id = $1
  and deleted_at isnull
  and company_id = $2
limit 1
`

type getCategoryParams struct {
	ID        int64 `json:"id"`
	CompanyID int64 `json:"company_id"`
}

func (q *Queries) getCategory(ctx context.Context, arg getCategoryParams) (Category, error) {
	row := q.db.QueryRowContext(ctx, getCategory, arg.ID, arg.CompanyID)
	var i Category
	err := row.Scan(
		&i.ID,
		&i.Name,
		&i.Description,
		&i.CompanyID,
		&i.CreatedAt,
		&i.UpdatedAt,
		&i.DeletedAt,
	)
	return i, err
}

const updateCategory = `-- name: updateCategory :one
update categories
set name        = coalesce($4, name),
    description = coalesce($5, description),
    updated_at  = $1
where id = $2
  and deleted_at isnull
  and company_id = $3
returning id, name, description, company_id, created_at, updated_at, deleted_at
`

type updateCategoryParams struct {
	UpdatedAt   sql.NullTime   `json:"updated_at"`
	ID          int64          `json:"id"`
	CompanyID   int64          `json:"company_id"`
	Name        sql.NullString `json:"name"`
	Description sql.NullString `json:"description"`
}

func (q *Queries) updateCategory(ctx context.Context, arg updateCategoryParams) (Category, error) {
	row := q.db.QueryRowContext(ctx, updateCategory,
		arg.UpdatedAt,
		arg.ID,
		arg.CompanyID,
		arg.Name,
		arg.Description,
	)
	var i Category
	err := row.Scan(
		&i.ID,
		&i.Name,
		&i.Description,
		&i.CompanyID,
		&i.CreatedAt,
		&i.UpdatedAt,
		&i.DeletedAt,
	)
	return i, err
}
