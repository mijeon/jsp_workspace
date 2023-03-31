--admin table 
create table admin(
	  admin_idx int primary key auto_increment
	, admin_id varchar(20)
	, admin_pass varchar(20)
	, admin_name varchar(20)
)default character set utf8;

--admin table insert
insert into admin(admin_id, admin_pass, admin_name) values('jeon', '1234', '저니');

--category table
create table category(
	  category_idx int primary key auto_increment
	, category_name varchar(30)
)default character set utf8;

--category table insert
insert into category(category_name) values('상의');
insert into category(category_name) values('하의');
insert into category(category_name) values('엑세서리');
insert into category(category_name) values('신발');
insert into category(category_name) values('가방');

--product table 
create table product(
	  product_idx int primary key auto_increment 
	, category_idx int 
	, product_name varchar(100)
	, brand varchar(100)
	, price int default 0
	, discount int default 0
	, detail text
	, constraint fk_category_product foreign key(category_idx) references category(category_idx)
)default character set utf8;

--pimg table
create table pimg(
	  pimg_idx int primary key auto_increment
	, product_idx int  
	, filename varchar(25)
	, constraint fk_product_pimg foreign key(product_idx) references product(product_idx)
)default character set utf8;

--color table
create table color(
	  color_idx int primary key auto_increment
	, product_idx int
	, color_name varchar(20)
	, constraint fk_product_color foreign key(product_idx) references product(product_idx)
)default character set utf8;

--psize table
create table psize(
	  psize_idx int primary key auto_increment
	, product_idx int
	, psize_name varchar(20)
	, constraint fk_product_psize foreign key(product_idx) references product(product_idx)
)default character set utf8;

--review table
create table review(
	  review_idx int primary key auto_increment
	, product_idx int
	, title varchar(30)
	, writer varchar(30)
	, content varchar(30)
	, regdate timestamp  default now()
	, constraint fk_product_review foreign key(product_idx) references product(product_idx)
)default character set utf8;