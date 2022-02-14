create schema ordergl;

use ordergl;

-- Supplier(SUPP_ID,SUPP_NAME,SUPP_CITY,SUPP_PHONE)

CREATE TABLE Supplier(
SUPP_ID int primary key,
SUPP_NAME varchar(50),
SUPP_CITY varchar(50),
SUPP_PHONE varchar(10)
);

CREATE TABLE `customer` (
  `CUS_ID` INT NOT NULL,
  `CUS_NAME` VARCHAR(20) NULL DEFAULT NULL,
  `CUS_PHONE` VARCHAR(10),
  `CUS_CITY` varchar(30) ,
  `CUS_GENDER` CHAR,
  PRIMARY KEY (`CUS_ID`));

CREATE TABLE IF NOT EXISTS `category` (
  `CAT_ID` INT NOT NULL,
  `CAT_NAME` VARCHAR(20) NULL DEFAULT NULL,
 
  PRIMARY KEY (`CAT_ID`)
  );

  CREATE TABLE IF NOT EXISTS `product` (
  `PRO_ID` INT NOT NULL,
  `PRO_NAME` VARCHAR(20) NULL ,
  `PRO_DESC` VARCHAR(60) NULL ,
  `CAT_ID` INT NOT NULL,
  PRIMARY KEY (`PRO_ID`),
  FOREIGN KEY (`CAT_ID`) REFERENCES CATEGORY (`CAT_ID`)
  
  );

 CREATE TABLE IF NOT EXISTS `product_details` (
  `PROD_ID` INT NOT NULL,
  `PRO_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `PROD_PRICE` INT NOT NULL,
  PRIMARY KEY (`PROD_ID`),
  FOREIGN KEY (`PRO_ID`) REFERENCES PRODUCT (`PRO_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER(`SUPP_ID`)
  
  );
CREATE TABLE IF NOT EXISTS `order` (
  `ORD_ID` INT NOT NULL,
  `ORD_AMOUNT` INT NOT NULL,
  `ORD_DATE` DATE,
  `CUS_ID` INT NOT NULL,
  `PROD_ID` INT NOT NULL,
  PRIMARY KEY (`ORD_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`),
  FOREIGN KEY (`PROD_ID`) REFERENCES PRODUCT_DETAILS(`PROD_ID`)
  );


CREATE TABLE IF NOT EXISTS `rating` (
  `RAT_ID` INT NOT NULL,
  `CUS_ID` INT NOT NULL,
  `SUPP_ID` INT NOT NULL,
  `RAT_RATSTARS` INT NOT NULL,
  PRIMARY KEY (`RAT_ID`),
  FOREIGN KEY (`SUPP_ID`) REFERENCES SUPPLIER (`SUPP_ID`),
  FOREIGN KEY (`CUS_ID`) REFERENCES CUSTOMER(`CUS_ID`)
  );


-- ----- Insert queries -----

-- supplier
insert into `supplier` values(1,"Rajesh Retails","Delhi",'1234567890');
insert into `supplier` values(2,"Appario Ltd.","Mumbai",'2589631470');
insert into `supplier` values(3,"Knome products","Banglore",'9785462315');
insert into `supplier` values(4,"Bansal Retails","Kochi",'8975463285');
insert into `supplier` values(5,"Mittal Ltd.","Lucknow",'7898456532');

-- CUSTOMER
INSERT INTO `CUSTOMER` VALUES(1,"AAKASH",'9999999999',"DELHI",'M');
INSERT INTO `CUSTOMER` VALUES(2,"AMAN",'9785463215',"NOIDA",'M');
INSERT INTO `CUSTOMER` VALUES(3,"NEHA",'9999999999',"MUMBAI",'F');
INSERT INTO `CUSTOMER` VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F');
INSERT INTO `CUSTOMER` VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M');

-- CATEGORY
INSERT INTO `CATEGORY` VALUES( 1,"BOOKS");
INSERT INTO `CATEGORY` VALUES(2,"GAMES");
INSERT INTO `CATEGORY` VALUES(3,"GROCERIES");
INSERT INTO `CATEGORY` VALUES (4,"ELECTRONICS");
INSERT INTO `CATEGORY` VALUES(5,"CLOTHES");
  
-- PRODUCT
INSERT INTO `PRODUCT` VALUES(1,"GTA V","DFJDJFDJFDJFDJFJF",2);
INSERT INTO `PRODUCT` VALUES(2,"TSHIRT","DFDFJDFJDKFD",5);
INSERT INTO `PRODUCT` VALUES(3,"ROG LAPTOP","DFNTTNTNTERND",4);
INSERT INTO `PRODUCT` VALUES(4,"OATS","REURENTBTOTH",3);
INSERT INTO `PRODUCT` VALUES(5,"HARRY POTTER","NBEMCTHTJTH",1);
  
-- PRODUCT_DETAILS
INSERT INTO PRODUCT_DETAILS VALUES(1,1,2,1500);
INSERT INTO PRODUCT_DETAILS VALUES(2,3,5,30000);
INSERT INTO PRODUCT_DETAILS VALUES(3,5,1,3000);
INSERT INTO PRODUCT_DETAILS VALUES(4,2,3,2500);
INSERT INTO PRODUCT_DETAILS VALUES(5,4,1,1000);

-- ORDER
INSERT INTO `ORDER` VALUES (50,2000,"2021-10-06",2,1);
INSERT INTO `ORDER` VALUES(20,1500,"2021-10-12",3,5);
INSERT INTO `ORDER` VALUES(25,30500,"2021-09-16",5,2);
INSERT INTO `ORDER` VALUES(26,2000,"2021-10-05",1,1);
INSERT INTO `ORDER` VALUES(30,3500,"2021-08-16",4,3);

-- RATING
INSERT INTO `RATING` VALUES(1,2,2,4);
INSERT INTO `RATING` VALUES(2,3,4,3);
INSERT INTO `RATING` VALUES(3,5,1,5);
INSERT INTO `RATING` VALUES(4,1,3,2);
INSERT INTO `RATING` VALUES(5,4,5,4);

select * from RATING;

-- Write queries for the following:

-- 3)	Display the number of the customer group by their genders who have placed any order of amount greater than or equal to Rs.3000.
-- 4)	Display all the orders along with the product name ordered by a customer having Customer_Id=2.
-- 5)	Display the Supplier details who can supply more than one product.
-- 6)	Find the category of the product whose order amount is minimum.
-- 7)	Display the Id and Name of the Product ordered after “2021-10-05”.
-- 8)	Display customer name and gender whose names start or end with character 'A'.
-- 9)	 Create a stored procedure to display the Rating for a Supplier if any along with the Verdict on that rating if any like if rating >4 then “Genuine Supplier” if rating >2 “Average Supplier” else “Supplier should not be considered”.

-- Answer 3 
select * from `order` where ord_amount >= 3000;

-- INNER JOIN between order and customer table
select cus_gender, count(*)
from `order`  inner join customer on `order`.cus_id = customer.cus_id 
where ord_amount >= 3000 group by customer.cus_gender;

-- Display all the orders along with the product name ordered by a customer having Customer_Id=2.
-- Join 3 tables order table product and product details

select * from `order` inner join product_details
on `order`.prod_id = product_details.prod_id 
inner join product on
product_details.pro_id = product.pro_id
where cus_id = 2;

-- 5 Display the Supplier details who can supply more than one product.

-- Find out supplier ids of the supplier supplying more than one product

select supp_id from product_details group by supp_id;

select * from supplier where supp_id IN 
(select supp_id from product_details group by supp_id having count(*)> 1);


-- 6)	Find the category of the product whose order amount is minimum.

select * from  `order`;

-- order, product details, product, category

select category.* from `order`
inner join product_details 
on product_details.prod_id = `order`.prod_id
inner join product 
on product_details.pro_id = product.pro_id
inner join category
on product.cat_id = category.cat_id
order by `order`.ord_amount limit 1;

-- 7)	Display the Id and Name of the Product ordered after “2021-10-05”.
-- order , product details, product

select product.pro_id, product.pro_name, product.pro_desc from `order` inner join 
product_details on 
`order`.prod_id = product_details.prod_id
inner join product on
product_details.pro_id = product.pro_id
where ord_date > '2021-10-05';


-- 8 Display customer name and gender whose names start or end with character 'A'.

-- HINT: like 'A%'

select cus_name, cus_gender from customer where customer.cus_name like 'A%' or customer.cus_name like '%A';

-- 9)	 Create a stored procedure to display the Rating for a Supplier if any 
-- along with the Verdict on that rating if any like if rating >4 then 
-- “Genuine Supplier” if rating >2 “Average Supplier” else “Supplier should not be considered”.

CREATE DEFINER=`root`@`localhost` PROCEDURE `categorize_supplier`()
BEGIN
select supplier.supp_id,supplier.supp_name,rating.rat_ratstars,
CASE
    WHEN rating.rat_ratstars >4 THEN 'Genuine Supplier'
    WHEN rating.rat_ratstars>2 THEN 'Average Supplier'
    ELSE 'Supplier should not be considered'
END AS verdict from rating inner join supplier on supplier.supp_id=rating.supp_id;
END


call categorize_supplier;





