-- 2-6 Entity 연관관계 예시 sql

use orderapp;
create table users
(
    id   bigint not null auto_increment,
    name varchar(255),
    primary key (id)
);

create table food
(
    id    bigint not null auto_increment,
    name  varchar(255),
    price float(53) not null,
    primary key (id)
);

ALTER TABLE users ADD food_id bigint;

INSERT INTO users (name, food_id) VALUES ('Robbie', 1);
INSERT INTO users (name, food_id) VALUES ('Robbert', 1);
INSERT INTO users (name, food_id) VALUES ('Robbie', 2);

ALTER TABLE food ADD user_id bigint;

INSERT INTO food (name, price, user_id) VALUES ('후라이드 치킨', 15000, 1);
INSERT INTO food (name, price, user_id) VALUES ('후라이드 치킨', 15000, 2);
INSERT INTO food (name, price, user_id) VALUES ('양념 치킨', 20000, 1);

-- 데이터 중복 해결을 위한 중간 테이블
create table orders
(
    id         bigint not null auto_increment,
    user_id    bigint,
    food_id    bigint,
    order_date date,
    primary key (id)
);


-- 중간테이블 orders를 만들어서 데이터 삽입
drop table if exists food;
drop table if exists users;
create table users
(
    id   bigint not null auto_increment,
    name varchar(255),
    primary key (id)
);

create table food
(
    id    bigint    not null auto_increment,
    name  varchar(255),
    price float(53) not null,
    primary key (id)
);

alter table orders
    add constraint orders_user_fk
        foreign key (user_id)
            references users (id);

alter table orders
    add constraint orders_food_fk
        foreign key (food_id)
            references food (id);

INSERT INTO users (name) VALUES ('Robbie');
INSERT INTO users (name) VALUES ('Robbert');

INSERT INTO food (name, price) VALUES ('후라이드 치킨', 15000);
INSERT INTO food (name, price) VALUES ('양념 치킨', 20000);
INSERT INTO food (name, price) VALUES ('고구마 피자', 30000);
INSERT INTO food (name, price) VALUES ('아보카도 피자', 50000);

INSERT INTO orders (user_id, food_id, order_date) VALUES (1, 1, SYSDATE());
INSERT INTO orders (user_id, food_id, order_date) VALUES (2, 1, SYSDATE());
INSERT INTO orders (user_id, food_id, order_date) VALUES (2, 2, SYSDATE());
INSERT INTO orders (user_id, food_id, order_date) VALUES (1, 4, SYSDATE());
INSERT INTO orders (user_id, food_id, order_date) VALUES (2, 3, SYSDATE());

SELECT u.name as username, f.name as foodname, o.order_date as orderdate
FROM users u
         INNER JOIN orders o on u.id = o.user_id
         INNER JOIN food f on o.food_id = f.id
WHERE o.user_id = 1;

SELECT u.name as username, f.name as foodname, o.order_date as orderdate
FROM food f
         INNER JOIN orders o on f.id = o.food_id
         INNER JOIN users u on o.user_id = u.id
WHERE o.user_id = 1;