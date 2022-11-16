create table companies
(
    id         bigserial               not null
        constraint companies_pk
        primary key,
    name       varchar                 not null,
    address    text,
    phone      varchar,
    email      varchar,
    created_at timestamp default now() not null,
    updated_at timestamp,
    deleted_at timestamp
);

create table up_users_companies_links
(
    user_id bigint not null,
    company_id bigint not null,
    role varchar not null
);

alter table up_users_companies_links
    add constraint up_users_companies_links_user_fk
        foreign key (user_id) references up_users (id);

alter table up_users_companies_links
    add constraint up_users_companies_links_company_fk
        foreign key (company_id) references up_users (id);