CREATE DATABASE ASSESMENT2

CREATE TABLE tblusers(
	user_id INT PRIMARY KEY,
	user_name VARCHAR(30),
	Email VARCHAR(30)
);


CREATE TABLE tblcategory(
	category_id INT PRIMARY KEY,
	category_name VARCHAR(100),
	discription VARCHAR(100) 
);



CREATE TABLE tblProducts(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(25),
	quiantity INT,
	product_price INT,
	category_id INT REFERENCES tblcategory(category_id)
);


CREATE TABLE tblsales(
	sales_id INT PRIMARY KEY,
	sales_user_id INT REFERENCES tblusers(user_id),
	Product_id INT REFERENCES tblProducts(product_id)
);

INSERT INTO tblusers VALUES(1001,'Akash','akash@gmail.com');
INSERT INTO tblusers VALUES(1002,'Arvind','arvin@gmail.com');
INSERT INTO tblusers VALUES(1003,'Sakshi','saksh@gmail.com');
INSERT INTO tblusers VALUES(1004,'Kumar','kumar@gmail.com');


INSERT INTO tblcategory VALUES(201,'Electronics','One stop for electronic items.');
INSERT INTO tblcategory VALUES(202,'Apparel','Apparel is the next destination for fashion.');
INSERT INTO tblcategory VALUES(203,'Grocery','All needs in one place.');


INSERT INTO tblproducts values (1,'Mobile Phone',1000,15000,201);
INSERT INTO tblproducts values (2,'Television',500,40000,201);
INSERT INTO tblproducts values (3,'Denims',2000,700,202);
INSERT INTO tblproducts values (4,'Vegetables',4000,40,203);
INSERT INTO tblproducts values (5,'Ethnic Wear',300,1500,202);
INSERT INTO tblproducts values (6,'Wireless Earphone',5000,2500,201);
INSERT INTO tblproducts values (7,'Lounge Wear',200,1600,202);
INSERT INTO tblproducts values (8,'Refrigerator',50,30000,201);
INSERT INTO tblproducts values (9,'Pulses',60,150,202);
INSERT INTO tblproducts values (10,'Fruits',100,250,202);

SELECT * FROM tblproducts;

--EXECUTE('SELECT * FROM tblproducts');

INSERT INTO tblsales VALUES(500,1001,1);
INSERT INTO tblsales VALUES(501,1002,1);
INSERT INTO tblsales VALUES(502,1003,2);
INSERT INTO tblsales VALUES(504,1004,3);
INSERT INTO tblsales VALUES(505,1004,1);
INSERT INTO tblsales VALUES(506,1004,1);
INSERT INTO tblsales VALUES(507,1002,2);
INSERT INTO tblsales VALUES(508,1003,1);
INSERT INTO tblsales VALUES(509,1001,7);
INSERT INTO tblsales VALUES(510,1001,8);
INSERT INTO tblsales VALUES(511,1002,9);

SELECT * FROM tblusers,tblcategory,tblproducts,tblsales;

-- 1.Write a function to fetch the names of the product,category and users along with the 
-- cost for each product sold
-- depending on the sales_id.
-- Also if the cost for each product is more than 2000, then display a message stating
-- that 'The product has gained profit'. 
-- If the product cost is between 500 and 1000, then raise a message stating that
-- 'The product has occured loss'. 
-- If the product cost is less than 500, then raise an exception stating 'No profit no loss'.



CREATE OR ALTER FUNCTION UDF_asses(@saleid INT)
RETURNS  TABLE
AS
	
	RETURN SELECT product_name,category_name,user_name,product_price,(
	CASE
			WHEN (product_price > 2000) THEN 'The product has gained profit'
			WHEN (product_price) BETWEEN 500 AND 1000 THEN 'The product has occured loss'
			WHEN (product_price) < 500 THEN 'No profit no loss'
			ELSE 'others'
	END
		)AS profit_loss
		FROM tblusers tu
		INNER JOIN tblsales ts
		ON ts.sales_user_id = tu.user_id
		INNER JOIN tblProducts tp
		ON ts.product_id = tp.product_id
		INNER JOIN tblcategory tc
		ON tp.category_id = tc.category_id
		WHERE sales_id = @saleid


SELECT * FROM UDF_asses(1000)



-- 2.Write a procedure to update the name of the category from 'Electronics' to 'Modern Gadgets'
-- and also 
-- fetch the category and product names when the userid is passed as the input parameter.



CREATE OR ALTER PROCEDURE USP_upFETCH(@usr_id INT)
AS
BEGIN
	UPDATE tblcategory
	SET category_name = 'Modern Gadgets'
	WHERE category_name = 'Electronics';
	
	
	IF((@usr_id IS NOT NULL) OR (EXISTS (SELECT user_id FROM tblusers WHERE user_id = @usr_id)))
		BEGIN
			SELECT category_name,count(category_name)
			FROM tblusers tu
			INNER JOIN tblsales ts
			ON ts.sales_user_id = tu.user_id
			INNER JOIN tblProducts tp
			ON ts.product_id = tp.product_id
			INNER JOIN tblcategory tc
			ON tp.category_id = tc.category_id
			WHERE user_id = @usr_id
			GROUP BY category_name
		END
	ELSE 
		 PRINT 'USER NOT FOUND';
	
END;


EXEC USP_upFETCH 1001;



















































--DECLARE @prod_price INT = 0;

	--SELECT @prod_price = product_price 
	--FROM tblProducts tp
	--JOIN tblsales ts
	--ON ts.Product_id = tp.product_id
	--WHERE sales_id = @saleid

	--IF (@prod_price < 500) 
	--BEGIN
	--print 'No profit no loss'
	--END
	--ELSE


	/*
(@productname VARCHAR(30),@category_name VARCHAR(30),@user_name VARCHAR(30),
 @product_price INT,@report VARCHAR(100))*/
 /*INSERT INTO @tbl*/


 CREATE OR ALTER demo()