create database eCommerce;

use eCommerce;

create table supplier (supp_id int primary key, supp_name varchar(50) not null, supp_city varchar(50) not null, supp_phone varchar(50) not null);

create table customer ( cus_id int primary key, cus_name varchar(20) not null, cus_phone varchar(10) not null, cus_city varchar(30) not null, cus_gender char);

create table category (cat_id int primary key, cat_name varchar(20) not null );

create table product ( pro_id int primary key, pro_name varchar(20) not null default "Dummy", pro_desc varchar(60), cat_id int, foreign key(cat_id) references category(cat_id));

create table supplier_pricing
(pricing_id int primary key, pro_id int, supp_id int , supp_price int default 0, foreign key(pro_id) references product(pro_id) , foreign key(supp_id) references supplier(supp_id));

create table Orders 
(order_id int primary key, order_amount int not null, order_date date not null, cus_id int , 
pricing_id int, foreign key(cus_id) references customer(cus_id), foreign key(pricing_id) references supplier_pricing(pricing_id));

create table rating(rat_id int primary key, order_id int , rat_ratstars int not null, foreign key(order_id) references orders(order_id));

insert into supplier values
(1,"Rajesh Retails", "Delhi", 1234567890),
(2,"Appario LTD", "Mumbai", 2589631470),
(3, "Knome products" , "Banglore", 9785462315),
(4,"Bansal Retails","Kochi", 8975463285),
(5,"Mittal Ltd.","Lucknow",7898456532);

insert into customer values
(1, "Aakash",9999999999,"Delhi", 'M'),
(2,"Aman", 9785463215, "Noida", 'M'),
(3,"Neha", 9999999999, "Mumbai", 'F'),
(4,"Megha", 9994562399, "Kolkata", 'F'),
(5,"Pulkit", 7895999999,"Lucknow",'M');

insert into category values
(1, "Books"),
(2, "Games"),
(3, "Groceries"),
(4, "Electronics"),
(5, "Clothes");

insert into product values
(1,"GTA V","Windows 7 and above with i5 processor and 8GB RAM",2),
(2,"T-SHIRT","SIZE-L with Black, Blue and White variations",5),
(3,"ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4),
(4,"OATS","Highly Nutritious from Nestle",3),
(5,"HARRY POTTER","Best Collection of all time by J.K Rowling",1),
(6,"MILK","1L Toned MIlk",3),
(7,"BOAT EARPHONES","1.5Meter long Dolby Atmos",4),
(8,"JEANS","Stretchable Denim Jeans with various sizes and color",5),
(9,"PROJECT IGI","compatible with windows 7 and above",2),
(10,"HOODIE","Black GUCCI for 13 yrs and above",5),
(11,"RICH DAD POOR DAD","Written by Robert Kiyosaki",1),
(12,"TRAIN YOUR BRAIN","By Shireen Stephen",1);

insert into supplier_pricing values
(1,1,2,1500),(2,3,5,30000),(3,5,1,3000),(4,2,3,2500),(5,4,1,1000);

INSERT INTO SUPPLIER_PRICING VALUES(6,12,2,780);
INSERT INTO SUPPLIER_PRICING VALUES(7,12,4,789);
INSERT INTO SUPPLIER_PRICING VALUES(8,3,1,31000);
INSERT INTO SUPPLIER_PRICING VALUES(9,1,5,1450);
INSERT INTO SUPPLIER_PRICING VALUES(10,4,2,999);
INSERT INTO SUPPLIER_PRICING VALUES(11,7,3,549);
INSERT INTO SUPPLIER_PRICING VALUES(12,7,4,529);
INSERT INTO SUPPLIER_PRICING VALUES(13,6,2,105);
INSERT INTO SUPPLIER_PRICING VALUES(14,6,1,99);
INSERT INTO SUPPLIER_PRICING VALUES(15,2,5,2999);
INSERT INTO SUPPLIER_PRICING VALUES(16,5,2,2999);


insert into orders values
(101,1500,"2021-10-06",2,1),
(102,1000,"2021-10-12",3,5),
(103,30000,"2021-09-16",5,2),
(104,1500,"2021-10-05",1,1),
(105,3000,"2021-08-16",4,3),
(106,1450,"2021-08-18",1,9),
(107,789,"2021-09-01",3,7),
(108,780,"2021-09-07",5,6),
(109,3000,"2021-00-10",5,3),
(110,2500,"2021-09-10",2,4),
(111,1000,"2021-09-15",4,5),
(112,789,"2021-09-16",4,7),
(113,31000,"2021-09-16",1,8),
(114,1000,"2021-09-16",3,5),
(115,3000,"2021-09-16",5,3),
(116,99,"2021-09-17",2,14);

insert into rating values
(1,101,4),
(2,102,3),
(3,103,1),
(4,104,2),
(5,105,4),
(6,106,3),
(7,107,4),
(8,108,4),
(9,109,3),
(10,110,5),
(11,111,3),
(12,112,4),
(13,113,2),
(14,114,1),
(15,115,1),
(16,116,0);


/*
question 3
*/
select t1.cus_gender,count(t1.cus_gender) as "No of Customers" from 
(select c.cus_name,c.cus_gender,c.cus_id,o.order_amount from customer c inner join orders o on c.cus_id = o.cus_id 
where o.order_amount >=3000 group by c.cus_id) as t1 group by t1.cus_gender;

/*
question 4
*/
select o.*,p.pro_name from orders o inner join supplier_pricing sp on sp.pricing_id = o.pricing_id inner join product p on p.pro_id = sp.pro_id where o.cus_id = 2;

/*
question 5
*/
select s.* from supplier_pricing sp inner join supplier s on s.supp_id = sp.supp_id group by sp.supp_id having count(sp.supp_id) > 1;


/*
question 6
*/
select c.cat_id,c.cat_name,min(sp.supp_price) as "MIN Price"
from category c inner join product p on p.cat_id = c.cat_id inner join supplier_pricing sp on p.pro_id = sp.pro_id group by p.cat_id order by p.cat_id asc;


/*
question 7
*/
SELECT p.pro_id,p.pro_name FROM supplier_pricing sp inner join product p on sp.pro_id = p.pro_id inner join orders o on o.pricing_id = sp.pricing_id 
where order_date > "2021-10-05";


/*
question 8
*/
select cus_name,cus_gender from customer where upper(cus_name) like 'A%' or upper(cus_name) like '%A';


/*
question 9
*/
delimiter &&
create procedure RatingService()
begin
select report.supp_id,report.supp_name,report.Average,
case
when report.Average = 5 then "Excellent Service"
when report.Average > 4 then "Good Service"
when report.Average > 2 then "Average Service"
else "Poor Service"
end as Type_of_Service from
(select final.supp_id,supplier.supp_name,final.Average from
(select test2.supp_id, sum(test2.rat_ratstars)/count(test2.rat_ratstars) as Average from
(select supplier_pricing.supp_id , test.order_id, test.rat_ratstars from supplier_pricing inner join
(select orders.pricing_id, rating.order_id, rating.rat_ratstars from orders inner join rating on rating.order_id = orders.order_id) as test
on test.pricing_id = supplier_pricing.pricing_id)
as test2 group by supplier_pricing.supp_id)
as final inner join supplier where final.supp_id = supplier.supp_id) as report;
end &&
delimiter ;

call RatingService();