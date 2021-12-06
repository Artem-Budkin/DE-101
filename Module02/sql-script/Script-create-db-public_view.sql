-- ************************************** "public"."calendar"

CREATE TABLE "public"."calendar"
(
 "year"       int4range NOT NULL,
 "quarter"    varchar(5) NOT NULL,
 "month"      int4range NOT NULL,
 "week"       int4range NOT NULL,
 "week_day"   int4range NOT NULL,
 "order_date" date NOT NULL,
 "ship_date"  date NOT NULL,
 CONSTRAINT "PK_203" PRIMARY KEY ( "order_date", "ship_date" )
);


-- ************************************** "public"."geography"

CREATE TABLE "public"."geography"
(
 "country"     varchar(13) NOT NULL,
 "city"        varchar(15) NOT NULL,
 "region"      varchar(7) NOT NULL,
 "postal_code" int4range NOT NULL,
 "state"       varchar(11) NOT NULL,
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
 "quantity"   int4range NOT NULL,
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


-- **************************************************************

-- insert unique values + generate_id
insert into public.shipping 
select 100+row_number() over(), ship_mode from (select distinct ship_mode from orders) a;

-- check data
select * from shipping
