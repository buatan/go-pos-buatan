create table contacts
(
    id            bigserial primary key,
    name          varchar   not null,
    phone         varchar   null,
    email         varchar   null,
    address       varchar   null,
    bank_account  text      null,
    contact_type varchar   not null,
    balance       decimal   not null default 0,
    company_id    bigint    not null,
    created_at    timestamp not null default now(),
    updated_at    timestamp null,
    deleted_at    timestamp null
);

alter table contacts
    add constraint company_contacts_link_fk
        foreign key (company_id) references companies (id);