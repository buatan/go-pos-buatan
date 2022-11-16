create table categories
(
    id          bigserial primary key,
    name        varchar   not null,
    description text      null,
    company_id  bigint    not null,
    created_at  timestamp not null default now(),
    updated_at  timestamp null,
    deleted_at  timestamp null
);

create table products
(
    id          bigserial primary key,
    name        varchar   not null,
    description text      null,
    cost        decimal   null,
    price       decimal   null,
    company_id  bigint    not null,
    created_at  timestamp not null default now(),
    updated_at  timestamp null,
    deleted_at  timestamp null
);

create table products_categories_links
(
    category_id bigint not null,
    product_id  bigint not null
);

alter table categories
    add constraint company_categories_links_fk
        foreign key (company_id) references companies (id);

alter table products
    add constraint company_products_links_fk
        foreign key (company_id) references companies (id);

alter table products_categories_links
    add constraint products_categories_links_category_fk
        foreign key (category_id) references categories (id);

alter table products_categories_links
    add constraint products_categories_links_product_fk
        foreign key (product_id) references products (id);