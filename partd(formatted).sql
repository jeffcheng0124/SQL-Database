/* (Database, Assignment Part D, Autumn 2021 */
/* First author's name: Sarrah Barodawala (13922277)*/
/* First author's email: sarrah.barodawala@student.uts.edu.au*/
/* Second author's name: Abina Kirubaharan (13890280) */
/* Second author's email: abina.kirubaharan@student.uts.edu.au */
/* Third author's name: Jeffrey Cheng (14284917)*/
/* Third author's email: jeffrey.cheng@student.uts.edu.au */
/* script name: partd.sql*/
/* purpose: Builds PostgreSQL tables for JBHIFI database */
/* date: 17/10/2021*/
/* The URL for the website related to this database is https://www.jbhifi.com.au/ */


--=================================================================================================
-- Drop the tables below

-- DROP TABLE IF EXISTS Order_T;
-- DROP TABLE IF EXISTS Product_T;
-- DROP TABLE IF EXISTS Orderline_T;
--=================================================================================================
-- Create and insert into the tables below

CREATE TABLE Product_T
(   ProductID numeric(3) not null,
    ProductName varchar(20) not null,
    ProductType varchar(20) not null,
    Price decimal(5,2) not null,
CONSTRAINT productPK PRIMARY KEY (ProductID)
);

INSERT INTO Product_T VALUES    (100, 'Mario Kart','CD Game', 70.00),
                                (101, 'Little Nightmares','CD Game', 60.00),
                                (102, 'Gaming Computer','Computer', 240.00),
                                (103, 'Nintendo Switch','Game Console', 400.00),
                                (104, 'Animal Crossing','Game', 70.00);

CREATE TABLE Order_T
(   OrderID numeric(3) not null,
    OrderDate date not null,
    DeliveryType varchar(3) not null,
CONSTRAINT Order_PK PRIMARY KEY(OrderID)
);

INSERT INTO Order_T VALUES          (10,'05/16/2021', 'CNC'),
                                    (11,'05/28/2021', 'CNC'),
                                    (12,'02/06/2021', 'P'),
                                    (13,'10/06/2021', 'CNC'),
                                    (14,'07/13/2021', 'P'),
                                    (15, '09/16/2021', 'P'),
                                    (16,'09/16/2021', 'P');

CREATE TABLE Orderline_T
(   OrderID numeric(3) not null,
    ProductID numeric(3) not null,
    Quantity int,
CONSTRAINT orderline_PK PRIMARY KEY (OrderID, ProductID),
CONSTRAINT orderline_FK1 FOREIGN KEY(OrderID) references Order_T(OrderID),
CONSTRAINT orderline_FK3 FOREIGN KEY(ProductID) references Product_T(ProductID)
);

INSERT INTO Orderline_T VALUES  (10, 100, '1'),
                                (10, 102, '1'),
                                (11, 100, '1'),
                                (12, 104, '5'),
                                (13, 101, '2'),
                                (13, 103, '3'),
                                (13, 102, '1'),
                                (14, 102, '1'),
                                (15, 103, '1'),
                                (16, 104, '5'),
                                (16, 101, '2');

--=================================================================================================
-- Select * from TableName Statements
-- Note: Please write the “select * from TableName” statements in one line.

-- 2.b.1: Question: 
-- 2.b.1: SELECT statement: 

select * from Product_T;
-- 2.b.2: Question: 
-- 2.b.2: SELECT statement:

select * from Order_T;
-- 2.b.3: Question: 
-- 2.b.3: SELECT statement:
select * from Orderline_T;

--=================================================================================================
-- 3.a: Question: Gets the maximum quantity delivered for each product

-- 3.a: SELECT statement uinsg Group by:

select Productid, max(Quantity) as Max_Quantity 
from Orderline_T 
group by ProductId
order by Productid;

-- 3.b: Question: Get the information of all orders, the products purchased and the total cost
-- 3.b: SELECT statement uisng Inner Join:
select ol.OrderID, ol.ProductID, Product_t.Price, Quantity, (Price * Quantity) as totalprice
FROM Product_T  INNER JOIN orderline_t ol on product_t.ProductId = ol.Productid
order by ol.orderid;

-- 3.c: Question: Get the earliest order which has delivery type CNC
-- 3.c: SELECT statement using Sub Query:

SELECT OrderID, OrderDate, DeliveryType FROM Order_T WHERE OrderDate = (SELECT MIN(OrderDate) FROM Order_T WHERE DeliveryType = 'CNC');


