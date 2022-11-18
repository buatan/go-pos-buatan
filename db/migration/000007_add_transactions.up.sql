create table transactions
(
    id               bigserial primary key,
    code             varchar   not null unique,
    date             timestamp not null default now(),
    subtotal         decimal   not null,
    discount         decimal   null,
    note             text      null,
    contact_id       bigint    not null,
    company_id       bigint    not null,
    transaction_type varchar   not null,
    created_at       timestamp not null default now(),
    updated_at       timestamp null
);

create table transaction_items
(
    id             bigserial primary key,
    transaction_id bigint  not null,
    product_id     bigint  null,
    product_name   varchar not null,
    quantity       decimal not null,
    price          decimal not null,
    discount       decimal null,
    note           text    null
);

create table payments
(
    id             bigserial primary key,
    transaction_id bigint    null,
    company_id     bigint    not null,
    code           varchar   not null,
    date           timestamp not null default now(),
    amount         decimal   not null,
    note           text      null,
    created_at     timestamp not null default now(),
    updated_at     timestamp null
);

alter table transactions
    add constraint company_transactions_links_fk
        foreign key (company_id) references companies (id);

alter table payments
    add constraint company_payments_links_fk
        foreign key (company_id) references companies (id);

alter table transactions
    add constraint transaction_contact_links_fk
        foreign key (contact_id) references contacts (id);

alter table transaction_items
    add constraint transaction_items_links_fk
        foreign key (transaction_id) references transactions (id);

alter table transaction_items
    add constraint transactions_item_product_links_fk
        foreign key (product_id) references products (id);

alter table payments
    add constraint transaction_payments_links_fk
        foreign key (transaction_id) references transactions (id);
