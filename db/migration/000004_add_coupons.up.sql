create table coupons
(
    id          bigserial primary key,
    code        varchar   not null unique,
    description text      null,
    coupon_type varchar   not null,
    amount      decimal   not null,
    company_id  bigint    not null,
    created_at  timestamp not null default now(),
    updated_at  timestamp null,
    deleted_at  timestamp null
);

alter table coupons
    add constraint company_coupons_link_fk
        foreign key (company_id) references companies (id);