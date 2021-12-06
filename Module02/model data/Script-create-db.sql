-- ************************************** "public"."calendar"

CREATE TABLE "public"."calendar"
(
 "year"       int NOT NULL,
 "quarter"    varchar(5) NOT NULL,
 "month"      int NOT NULL,
 "week"       int NOT NULL,
 "week_day"   int NOT NULL,
 "order_date" date NOT NULL,
 "ship_date"  date NOT NULL,
 CONSTRAINT "PK_203" PRIMARY KEY ( "order_date", "ship_date" )
);


-- ************************************** "public"."geography"

CREATE TABLE "public"."geography"
(
 "country"     varchar(20) NOT NULL,
 "city"        varchar(20) NOT NULL,
 "region"      varchar(10) NOT NULL,
 "postal_code" int NOT NULL,
 "state"       varchar(20) NOT NULL,
 "geo_id"      int NOT NULL,
 CONSTRAINT "PK_194" PRIMARY KEY ( "geo_id" )
);


-- ************************************** "public"."product"

CREATE TABLE "public"."product"
(
 "category"     varchar(15) NOT NULL,
 "subcategory"  varchar(11) NOT NULL,
 "segment"      varchar(11) NOT NULL,
 "product_name" varchar(127) NOT NULL,
 "product_id"   int NOT NULL,
 CONSTRAINT "PK_218" PRIMARY KEY ( "product_id" )
);


-- ************************************** "public"."shipping"

CREATE TABLE "public"."shipping"
(
 "ship_id"   int NOT NULL,
 "ship_mode" varchar(14) NOT NULL,
 CONSTRAINT "PK_304" PRIMARY KEY ( "ship_id" )
);

-- ************************************** "public"."sales"

CREATE TABLE "public"."sales"
(
 "order_id"   integer NOT NULL,
 "sales"      numeric(9,2) NOT NULL,
 "quantity"   int NOT NULL,
 "discount"   numeric(4,2) NOT NULL,
 "profit"     numeric(21,16) NOT NULL,
 "date"       date NOT NULL,
 "product_id" int NOT NULL,
 "order_date" date NOT NULL,
 "ship_date"  date NOT NULL,
 "geo_id"     int NOT NULL,
 "ship_id"    int NOT NULL,
 "row_id"     integer NOT NULL,
 CONSTRAINT "PK_182" PRIMARY KEY ( "row_id" ),
 CONSTRAINT "FK_292" FOREIGN KEY ( "product_id" ) REFERENCES "public"."product" ( "product_id" ),
 CONSTRAINT "FK_295" FOREIGN KEY ( "order_date", "ship_date" ) REFERENCES "public"."calendar" ( "order_date", "ship_date" ),
 CONSTRAINT "FK_299" FOREIGN KEY ( "geo_id" ) REFERENCES "public"."geography" ( "geo_id" ),
 CONSTRAINT "FK_307" FOREIGN KEY ( "ship_id" ) REFERENCES "public"."shipping" ( "ship_id" )
);

CREATE INDEX "FK_294" ON "public"."sales"
(
 "product_id"
);

CREATE INDEX "FK_298" ON "public"."sales"
(
 "order_date",
 "ship_date"
);

CREATE INDEX "FK_301" ON "public"."sales"
(
 "geo_id"
);

CREATE INDEX "FK_309" ON "public"."sales"
(
 "ship_id"
);


--*****************************************************************
drop table sales 
drop table geography 
drop table shipping 
drop table calendar 
drop table product 
-- **************************************************************

-- insert unique values + generate_id
insert into public.shipping 
select 100+row_number() over(), ship_mode from (select distinct ship_mode from orders) a;

-- check data
select * from shipping



-- Data !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--last
--insert into sales 
select
	order_id,
	row_id,
	sales,
	quantity,
	profit
	discount,
	s.ship_id
from orders o
inner join shipping s on o.ship_mode = s.ship_mode 

--first
insert into geography 
select 
	country,
	city,
	region,
	postal_code,
	state,
	row_number() over() as geo_id -- don't have some string
from orders;

select * 
from orders
where country = 'United States' and city = 'Burlington' and postal_code = null



alter table geography alter column city type varchar(20);

--shipping full

insert into product 
select
	product_id,
	category,
	subcategory,
	segment,
	product_name
from orders

insert into calendar 
select
	order_date,
	ship_date,
	extract(year from order_date) as year,
	extract(quarter from order_date) as quarter,
	extract(month from order_date) as month,
	extract('week' from order_date) as week,
	extract(isodow from order_date) as week_day
from orders

select * from orders

