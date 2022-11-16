create table if not exists public.up_users
(
    id                   bigserial primary key,
    name                 character varying,
    username             character varying           not null,
    email                character varying           not null,
    provider             character varying           not null default 'local',
    password             character varying           not null,
    reset_password_token character varying,
    confirmation_token   character varying           not null,
    confirmed            boolean                     not null default false,
    blocked              boolean                     not null default false,
    created_at           timestamp without time zone not null default now(),
    updated_at           timestamp without time zone,
    deleted_at           timestamp without time zone
);
create unique index up_users_uk_username on up_users using btree (username);
create unique index up_users_uk_email on up_users using btree (email);
comment on table public.up_users is 'up_users';

