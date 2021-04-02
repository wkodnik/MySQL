/*DATABASE Test_2*/
CREATE SCHEMA ASSIGN_2;


/*CREATE TABLE Rep (RepNo, Rep_fname, Rep_lname, rep_SIN)*/
CREATE TABLE ASSIGN_2.Rep(
 	RepNo VARCHAR(20),
	Rep_fname VARCHAR(20),
	Rep_lname VARCHAR(20),
	rep_SIN VARCHAR(20),
	CONSTRAINT ASSIGN_2.Rep_PK PRIMARY KEY(RepNo),  /*RepNo  ASSIGNED AS PRIMARY KEY*/
	CONSTRAINT ASSIGN_2.rep_SIN_UK UNIQUE(rep_SIN));  /*rep_SIN ASSIGNED AS UNIQUE VALUE*/

/*CREATE TABLE Customer (CustNo, Cust_fname, Cust_lname, city, RepNo)*/
CREATE TABLE ASSIGN_2.Customer(
	CustNo VARCHAR(20),
	Cust_fname VARCHAR(20),
	Cust_lname VARCHAR(20),
	RepNo VARCHAR(20),
            	city VARCHAR(20) DEFAULT 'TORONTO', /*city ASSIGNED AS DEFAULT VALUE 'TORONTO'*/
	CONSTRAINT ASSIGN_2.Customer_PK PRIMARY KEY(CustNo),  /*CustNo  ASSIGNED AS PRIMARY KEY*/
	CONSTRAINT ASSIGN_2.RepNo_FK FOREIGN KEY(RepNo) 
	REFERENCES ASSIGN_2.Rep(RepNo)); /*RepNo ASSIGNED FOREIGN KEY REFERENCES TO Rep TABLE */
/*DROP TABLE ASSIGN_2.Customer;*/

/*CREATE TABLE Order (OrderNo, Order_date, CustNo)*/
CREATE TABLE ASSIGN_2.Order(
	OrderNo VARCHAR(20),
	Order_date DATE,
	CustNo VARCHAR(20) NOT NULL, /*CustNo  ASSIGNED AS NOT NULL*/
	CONSTRAINT ASSIGN_2.Order_PK PRIMARY KEY(OrderNo),  /*OrderNo  ASSIGNED AS PRIMARY KEY*/
	CONSTRAINT ASSIGN_2.CustNo_FK FOREIGN KEY(CustNo) 
	REFERENCES ASSIGN_2.Customer(CustNo)); /*CustNo ASSIGNED FOREIGN KEY REFERENCES TO Customer TABLE */

/*CREATE TABLE Part (PartNo, Part_desc, warehouse_name)*/
CREATE TABLE ASSIGN_2.Part(
	PartNo VARCHAR(20),
	Part_desc VARCHAR(20),
	warehouse_name VARCHAR(20), 
	CONSTRAINT ASSIGN_2.Part_PK PRIMARY KEY(PartNo), /*PartNo  ASSIGNED AS PRIMARY KEY*/
	CONSTRAINT ASSIGN_2.warehouse_name_CK CHECK(warehouse_name = 'LIVINGART'));

/*CREATE TABLE Order_detail (OrderNo, PartNo, qty_sold, sold_price)*/
CREATE TABLE ASSIGN_2.Order_detail(
	OrderNo VARCHAR(20),
	PartNo VARCHAR(20),
	qty_sold INTEGER,
	sold_price DECIMAL(6, 2),
	CONSTRAINT ASSIGN_2.OrderNo_FK FOREIGN KEY(OrderNo) 
	REFERENCES ASSIGN_2.Order(OrderNo),
	CONSTRAINT ASSIGN_2.PartNo_FK FOREIGN KEY(PartNo) 
	REFERENCES ASSIGN_2.Part(PartNo));

/*--------------Rep TABLE----------------*/ 
/*INSERT INTO TABLE */

INSERT INTO ASSIGN_2.Rep (RepNo, Rep_fname, Rep_lname, rep_SIN)
	VALUES('P001', 'GEORGE', 'TSANG', '111222333'),
                             ('P002', 'DMYTRO', 'SUBBOTIN', '222333444'),
	 ('P003', 'LYUDMYLA', 'MENSHUN', '333444555');

/*UPDATE TABLE */

UPDATE ASSIGN_2.Rep
	SET rep_SIN = '000000111'
	WHERE RepNo = 'P002' ;

UPDATE ASSIGN_2.Rep
	SET Rep_fname = 'VIN',
	       Rep_lname = 'KONG'
	WHERE RepNo = 'P002' ;
	
/*DELETE FROM TABLE */

DELETE FROM ASSIGN_2.Rep; /*WHERE RepNo = 'P001';*/

/*--------------Customer TABLE----------------*/ 
/*INSERT INTO TABLE */

INSERT INTO ASSIGN_2.Customer (CustNo, Cust_fname, Cust_lname, city, RepNo)
	VALUES('C001', 'ANN', 'LYN', 'ETOBICOKE', 'P001'),
                             ('C002', 'JIUN', 'KO', 'NORTH YORK', 'P002'),
	 ('C003', 'CODEY', 'JONSTON', 'LONDON', 'P003');

/*UPDATE TABLE */

UPDATE ASSIGN_2.Customer
	SET RepNo = 'P001'
	WHERE CustNo = 'C002' ;

UPDATE ASSIGN_2.Customer
	SET Cust_fname = 'DON',
	       Cust_lname = 'HUAN',
	       city = 'YORK'
	WHERE CustNo = 'C003' ;

/*DELETE FROM TABLE */

DELETE FROM ASSIGN_2.Customer; /*WHERE CustNo = 'C001';*/

/*--------------Order TABLE----------------*/ 
/*INSERT INTO TABLE */

INSERT INTO ASSIGN_2.Order (OrderNo, Order_date, CustNo)
	VALUES('O002233', '1/22/2017', 'C001'),
                             ('O000111', '11/23/2017', 'C002'),
	 ('O000022', '2/5/2017', 'C003');

/*UPDATE TABLE */

UPDATE ASSIGN_2.Order
	SET CustNo = 'C001'
	WHERE OrderNo = 'O000022' ;

UPDATE ASSIGN_2.Order
	SET Order_date = '8/22/2017',
	       CustNo = 'C002'
	WHERE OrderNo = 'O000022' ;

/*DELETE FROM TABLE */

DELETE FROM ASSIGN_2.Order; /*WHERE OrderNo = 'O002233';*/

/*--------------Part TABLE----------------*/ 
/*INSERT INTO TABLE */

INSERT INTO ASSIGN_2.Part (PartNo, Part_desc, warehouse_name)   /*ASK FOR CHANGING WARHOUSE NAME*/
	VALUES('P001', 'PEN', 'LIVINGART'),
                             ('P002', 'BOOK', 'LIVINGART'),
	 ('P003', 'NOTEBOOK', 'LIVINGART');

/*UPDATE TABLE */

UPDATE ASSIGN_2.Part
	SET warehouse_name = 'C001'
	WHERE PartNo = 'P001' ;

UPDATE ASSIGN_2.Part
	SET Part_desc = 'KEYBOARD'
	WHERE PartNo = 'P001' ;

/*DELETE FROM TABLE */

DELETE FROM ASSIGN_2.Part; /*WHERE PartNo = 'P001';*/

/*--------------Order_detail TABLE----------------*/ 
/*INSERT INTO TABLE */

INSERT INTO ASSIGN_2.Order_detail (OrderNo, PartNo, qty_sold, sold_price)
	VALUES('O002233', 'P001', 5, 1.15),
                             ('O000111', 'P002', 10, 2.35),
	 ('O000022', 'P003', 15, 15.78);

/*UPDATE TABLE */

UPDATE ASSIGN_2.Order_detail
	SET sold_price = 18.55
	WHERE PartNo = 'P001' ;

UPDATE ASSIGN_2.Order_detail
	SET qty_sold = 22,
                                     sold_price = 3.79
	WHERE PartNo = 'P002' ;

/*DELETE FROM TABLE */

DELETE FROM ASSIGN_2.Order_detail; /*WHERE PartNo = 'P001';*/



/*SELECT*/
/*Rep (RepNo, Rep_fname, Rep_lname, rep_SIN)*/
/*Customer (CustNo, Cust_fname, Cust_lname, city, RepNo)*/
/*Order (OrderNo, Order_date, CustNo)*/
/*Part (PartNo, Part_desc, warehouse_name)*/
/*Order_detail (OrderNo, PartNo, qty_sold, sold_price)*/

SELECT Rep_lname, rep_SIN, Cust_lname, CustNo
	FROM  ASSIGN_2.Rep, ASSIGN_2.Customer
	WHERE ASSIGN_2.Customer.RepNo = ASSIGN_2.Rep.RepNo AND ASSIGN_2.Customer.RepNo = 'P001';

SELECT Rep_lname, Cust_lname, CustNo, city
	FROM  ASSIGN_2.Rep, ASSIGN_2.Customer
	WHERE ASSIGN_2.Customer.RepNo = ASSIGN_2.Rep.RepNo AND ASSIGN_2.Customer.RepNo = 'P001';

SELECT Rep_lname, Cust_lname, Order_date
	FROM ASSIGN_2.Rep AS R
		JOIN ASSIGN_2.Customer AS C
                                                           ON (R.RepNo = C.RepNo)
		JOIN ASSIGN_2.Order AS O
		ON (C.CustNo = O.CustNo);

/*--------------Alter the structure----------------*/ 
/*Rep (RepNo, Rep_fname, Rep_lname, rep_SIN)*/
/*Customer (CustNo, Cust_fname, Cust_lname, city, RepNo)*/
/*Order (OrderNo, Order_date, CustNo)*/
/*Part (PartNo, Part_desc, warehouse_name)*/
/*Order_detail (OrderNo, PartNo, qty_sold, sold_price)*/


ALTER TABLE ASSIGN_2.Rep
	ADD COLUMN RepDESC VARCHAR(100);

UPDATE ASSIGN_2.Rep
	SET  RepDESC = 'SOMEDESC'
	WHERE RepNo = 'P001';

SELECT * FROM ASSIGN_2.Rep;

ALTER TABLE ASSIGN_2.Customer
	DROP CONSTRAINT ASSIGN_2.RepNo_FK;

ALTER TABLE ASSIGN_2.Customer
	ADD CONSTRAINT ASSIGN_2.RepNo_FK FOREIGN KEY(RepNo)
	REFERENCES ASSIGN_2.Rep(RepNo);
                              
ALTER TABLE ASSIGN_2.Part
	DROP CONSTRAINT ASSIGN_2.warehouse_name_CK;

ALTER TABLE ASSIGN_2.Part
	ADD CONSTRAINT ASSIGN_2.warehouse_name_CK CHECK(warehouse_name = 'LIVINGART');

/*--------------Create an Index and a View------------------*/
/*Rep (RepNo, Rep_fname, Rep_lname, rep_SIN)*/
/*Customer (CustNo, Cust_fname, Cust_lname, city, RepNo)*/
/*Order (OrderNo, Order_date, CustNo)*/
/*Part (PartNo, Part_desc, warehouse_name)*/
/*Order_detail (OrderNo, PartNo, qty_sold, sold_price)*/

/*---------------------------------------------------------------*/
DROP VIEW ASSIGN_2.Rep_VW;

CREATE VIEW  ASSIGN_2.Rep_VW (RNUM, RFNAME, RLNAME, RSIN)
AS
SELECT RepNo, Rep_fname, Rep_lname, rep_SIN
	FROM  ASSIGN_2.Rep;

SELECT * FROM  ASSIGN_2.Rep_VW;

CREATE INDEX ASSIGN_2.REP_LNAME_IDX
	ON ASSIGN_2.Rep(Rep_lname);
/*---------------------------------------------------------------*/
/*---------------------------------------------------------------*/
DROP VIEW ASSIGN_2.Customer_VW;

CREATE VIEW  ASSIGN_2.Customer_VW (CFNAME, CLNAME, CCITY, RNUM)
AS
SELECT Cust_fname, Cust_lname, city, RepNo
	FROM  ASSIGN_2.Customer;

SELECT * FROM  ASSIGN_2.Customer_VW;

CREATE INDEX ASSIGN_2.CUST_LNAME_IDX
	ON ASSIGN_2.Customer(Cust_lname);

/*-----------------------SELECT------------------*/

SELECT RFNAME, RLNAME, RSIN, CFNAME, CLNAME, CCITY
	FROM ASSIGN_2.Rep_VW R
	JOIN ASSIGN_2.Customer_VW C
	ON (R.RNUM = C.RNUM AND R.RNUM = 'P003') ;


