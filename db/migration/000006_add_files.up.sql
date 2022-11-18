create table files
(
    id         bigserial primary key,
    name       varchar   not null,
    url        varchar   not null,
    file_type  varchar   not null,
    company_id bigint    not null,
    created_at timestamp not null default now(),
    updated_at timestamp null,
    deleted_at timestamp null
);

alter table files
    add constraint company_files_links_fk
        foreign key (company_id) references companies (id);