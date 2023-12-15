CREATE DATABASE FLIGHTS

USE FLIGHTS

CREATE TABLE tblCustomer(
CustId VARCHAR(5) PRIMARY KEY,
CustName VARCHAR(20)
);

INSERT INTO tblCustomer VALUES('c301','John');
INSERT INTO tblCustomer VALUES('c302','Sam');
INSERT INTO tblCustomer VALUES('c303','Robert');
INSERT INTO tblCustomer VALUES('c304','Albert');
INSERT INTO tblCustomer VALUES('c305','Jack');

CREATE TABLE tblFlight(
FlightId VARCHAR(5) PRIMARY KEY,
FlightName VARCHAR(40),
FlightType VARCHAR(30),
Source VARCHAR(20),
Destination VARCHAR(20),
FlightCharge INT,
TicketsAvailable INT,
TravelClass VARCHAR(20)
)

INSERT INTO tblFlight VALUES('F101','Spice Jet Airlines',
'Domestic','Mumbai','Kolkata',6000,200,'Economy')

INSERT INTO tblFlight VALUES('F102','Indian Airlines',
'International','Delhi','Germany',15000,120,'Business')

INSERT INTO tblFlight VALUES('F103','Deccan Airlines',
'Domestic','Chennai','Bengaluru',4000,210,'Economy')

INSERT INTO tblFlight VALUES('F104','British Airways',
'International','London','Italy',25000,100,'Economy')

INSERT INTO tblFlight VALUES('F105','Swiss Airlines',
'International','Zurich','Spain',10000,150,'Business')


CREATE TABLE booking(
bookingid INT IDENTITY(200,1) PRIMARY KEY,
flightid VARCHAR(5),
custid VARCHAR(5),
travelclass Varchar(20),
Bookingdate DATE,
noOfSeats INT,
totalAmt INT,
FOREIGN KEY(flightid) REFERENCES tblFlight(FlightId),
FOREIGN KEY(custid) REFERENCES tblCustomer(CustId)
);

INSERT INTO booking(flightid,custid,travelclass,Bookingdate,noOfSeats,totalAmt) 
VALUES('F101','c301','Business','22/mar/2018',2,24000)

INSERT INTO booking(flightid,custid,travelclass,Bookingdate,noOfSeats,totalAmt) 
VALUES('F105','c303','Business','17/mar/2018',1,30000)

INSERT INTO booking(flightid,custid,travelclass,Bookingdate,noOfSeats,totalAmt) 
VALUES('F103','c302','Economy','23/Jun/2018',2,6000)

INSERT INTO booking(flightid,custid,travelclass,Bookingdate,noOfSeats,totalAmt) 
VALUES('F101','c302','Economy','12/OCT/2018',2,20000)

INSERT INTO booking(flightid,custid,travelclass,Bookingdate,noOfSeats,totalAmt) 
VALUES('F104','c303','Business','16/jan/2019',2,50000)

INSERT INTO booking(flightid,custid,travelclass,Bookingdate,noOfSeats,totalAmt) 
VALUES('F105','c301','Business','22/mar/2018',2,60000)

INSERT INTO booking(flightid,custid,travelclass,Bookingdate,noOfSeats,totalAmt) 
VALUES('F104','c304','Economy','16/FEB/2019',2,44000)

INSERT INTO booking(flightid,custid,travelclass,Bookingdate,noOfSeats,totalAmt) 
VALUES('F101','c304','Business','18/sep/2019',2,24000)

CREATE OR ALTER PROCEDURE usp_BookTheTicket(@CustId VARCHAR(5),@FlightId VARCHAR(5),@NoOfTickets INT,@available_ticket INT OUTPUT)
AS
BEGIN
	IF((@CustId IS NULL) OR  ( NOT EXISTS(SELECT custid
											  FROM tblCustomer 
											  WHERE CustId = @CustId)))
	BEGIN
		PRINT'INVALID CUSTOMER ID'
		RETURN -1
	END

	IF((@FlightId IS NULL) OR  (NOT EXISTS(SELECT FlightId
											  FROM tblFlight 
											  WHERE FlightId = @FlightId)))
	BEGIN
		PRINT'INVALID FLIGHT ID'
		RETURN -2
	END

	IF(@NoOfTickets < = 0)
	BEGIN
		PRINT 'Invalid Quantity'
		RETURN -3
	END
	IF(@NoOfTickets > (SELECT TicketsAvailable 
				       FROM tblFlight
					   WHERE FlightId = @FlightId))
	BEGIN
		RETURN -4
	END

	DECLARE @TotalAmt INT,@bookingDate DATE,@flightCh INT,@travelclass Varchar(20)
	SELECT @TotalAmt = @NoOfTickets * FlightCharge 
	FROM tblFlight 
	WHERE FlightId = @FlightId

	SELECT @travelclass = TravelClass
	FROM tblFlight 
	WHERE FlightId = @FlightId

	SET @bookingDate = GETDATE()

	BEGIN TRY
	INSERT INTO booking(flightid,custid,travelclass,Bookingdate,noOfSeats,totalAmt)
	VALUES(@FlightId,@CustId,@travelclass,@bookingDate,@NoOfTickets,@TotalAmt)

	UPDATE tblFlight
	SET TicketsAvailable = TicketsAvailable - @NoOfTickets
	WHERE FlightId = @FlightId

	SELECT @available_ticket = TicketsAvailable
	FROM tblFlight
	WHERE FlightId = @FlightId

	RETURN 1
	END TRY

	BEGIN CATCH
	RETURN -99
	END CATCH
END

DECLARE @ret INT,@out INT
EXEC @ret = usp_BookTheTicket 'c301','F105',2,@out OUTPUT
print @ret
PRINT @out


SELECT * FROM tblCustomer

SELECT * FROM tblFlight

SELECT * FROM booking



--FUNCTION 
CREATE OR ALTER FUNCTION ufn_BookedDetails(@bookingId INT)
RETURNS TABLE
AS
RETURN SELECT b.BookingId,tc.CustName,FlightName,Source,Destination,BookingDate,noOfSeats,TotalAmt
	FROM tblCustomer tc
	INNER JOIN booking b ON b.custid = tc.CustId
	INNER JOIN tblFlight tf ON tf.FlightId = b.flightid
	WHERE bookingId = @bookingId

SELECT * FROM ufn_BookedDetails(202)




/*
1.Identify the customer(s) who have not booked any flight tickets or not booked any 
flights tickets of travel class ‘Economy’.Display custid and custname of the identified 
customer(s). 
*/

SELECT DISTINCT([tc].[custid]), [custname]
FROM [tblCustomer] tc
LEFT JOIN [booking] b
ON tc.CustId  = b.custid
WHERE b.custid IS NULL OR b.travelclass !='Economy'


/*
2.Identify the booking(s) with flightcharge greater than the average flightcharge of all the 
flights booked for the same travel class. Display flightid, flightname and  custname of 
the identified bookings(s). 
*/
SELECT tf.flightid,flightname,custname
FROM tblcustomer tc
INNER JOIN booking b ON b.custid = tc.CustId
INNER JOIN tblflight tf ON tf.FlightId = b.flightid
WHERE tf.FlightCharge > (SELECT AVG(FlightCharge)
						 FROM tblFlight)


/*
3.Identify the bookings done by the same customer for the same flight type and travel 
class. Display flightid and the flighttype of the identified bookings. 
*/

SELECT * FROM tblCustomer

SELECT * FROM tblFlight

SELECT * FROM booking

SELECT DISTINCT(tf.flightid),flighttype
FROM booking a
INNER JOIN booking b ON b.bookingid != a.bookingid
INNER JOIN tblflight tf ON tf.FlightId = b.flightid
WHERE b.flightid = a.flightid AND b.custid = a.custid



/*4.Identify the flight(s) for which the bookings are done to destination ‘Kolkata’, ‘Italy’ or 
‘Spain’. Display flightid and flightcharge of the identified booking(s) in the increasing 
order of flightname and decreasing order of flightcharge. 
*/

SELECT b.FlightId,FlightCharge
FROM tblFlight tf
INNER JOIN booking b ON b.flightid = tf.FlightId
WHERE Destination IN('Kolkata','Italy','Spain')
ORDER BY flightname,FlightCharge DESC

/*
5.Identify the month(s) in which the maximum number of bookings are made. Display 
custid and custname of the customers who have booked flights tickets in the identified 
month(s). 
*/

SELECT tc.custid,custname
FROM tblCustomer tc
INNER JOIN booking b ON tc.CustId = b.custid
WHERE DATEPART(mm,b.Bookingdate) = (SELECT TOP 1 DATEPART(mm,Bookingdate) AS month
		FROM booking
		GROUP BY DATEPART(mm,Bookingdate)
		ORDER BY COUNT(DATEPART(mm,Bookingdate)) DESC)


/*
6.Identify the booking(s) done in the year 2019 for the flights having the letter ‘u’ 
anywhere in their source or destination and booked by the customer having atleast 5 
characters in their name. Display bookingid prefixed with ‘B’ as “BOOKINGID” ( column 
alias) and the numeric part of custid as “CUSTOMERID” (column alias) for the identified 
booking(s). 
*/


SELECT CONCAT('B',b.bookingid) AS BOOKINGID,SUBSTRING(tc.CUSTID,2,4) AS CUSTOMERID
FROM booking b
INNER JOIN tblFlight tf ON b.flightid = tf.FlightId
INNER JOIN tblCustomer tc ON b.custid = tc.CustId
WHERE DATEPART(YYYY,Bookingdate) = 2019 AND (tf.Source LIKE '%u%' OR tf.Destination LIKE '%u%') AND tc.CustName LIKE '_____%'


/*
7.Identify the customer(s) who have booked the seats of travel class ‘Business’ for 
maximum number of times. Display custid and custname of the identified customer(s). 
*/

SELECT TOP 1 tc.custid,CustName
FROM tblCustomer tc
INNER JOIN booking b ON tc.CustId = b.custid
INNER JOIN tblFlight tf ON tf.FlightId = b.flightid
WHERE tf.TravelClass = 'Business'
GROUP BY tf.travelclass,tc.custid,CustName
ORDER BY tf.travelclass DESC


/*
8.Identify the bookings done with the same flightcharge. For every customer who has 
booked the identified bookings, display custname and bookingdate as “BDATE” (column 
alias). Display ‘NA’ in BDATE if the customer does not have any booking or if no such 
booking is done by the customer. 
*/
SELECT CustName,(CASE
WHEN Bookingdate IS NOT NULL THEN Bookingdate
ELSE 'NA'
END)
FROM tblCustomer tc
INNER JOIN booking b ON b.custid = tc.CustId
LEFT JOIN tblFlight tf ON tf.FlightId = b.flightid
WHERE bookingid IN (select bookingid
FROM booking
WHERE flightid IN (SELECT flightid
				   FROM booking
				   GROUP BY flightid
				   HAVING COUNT(flightid) >= 2))


/*
9. Identify the customers who have paid highest flightcharge for the travel class economy. write a sql query to display id,
flightname and name of the identified customers

*/

SELECT tf.flightid,FlightName,custname
FROM tblFlight tf
INNER JOIN booking b ON b.flightid = tf.FlightId
INNER JOIN tblCustomer tc ON tc.CustId = b.custid
WHERE tf.FlightId IN (SELECT fli.flight_id FROM (SELECT TOP 1 b.flightid as flight_id
					FROM booking b
					INNER JOIN tblFlight tf ON b.flightid = tf.FlightId
					WHERE b.TravelClass = 'Economy'
					GROUP BY b.flightid,tf.FlightCharge
					ORDER BY tf.FlightCharge DESC
					 ) as fli )
					
					--OR

SELECT TOP 1 WITH TIES tf.flightid,FlightName,custname
FROM tblFlight tf
INNER JOIN booking b ON b.flightid = tf.FlightId
INNER JOIN tblCustomer tc ON tc.CustId = b.custid
WHERE b.TravelClass = 'Economy'
ORDER BY tf.FlightCharge DESC


--10.Identify the International flight(s) which are booked for the maximum number of

--times.Write a SQL query to display id and name of the identified flights.

--SELECT * FROM booking

SELECT TOP 1 b.flightid,tf.flightname
FROM tblFlight tf
JOIN booking b
ON tf.FlightId = b.flightid
WHERE tf.FlightType = 'International'
GROUP BY b.flightid,tf.flightname
ORDER BY count(b.flightid) DESC

--11.Identify the customer(s) who have bookings during the months of October 2018 to

--January 2019 and paid overall total flightcharge less than the average flightcharge of all

--bookings belonging to travel class ‘Business’. Write a SQL query to display id and name

--of the identified customers.
SELECT tc.CustId,tc.CustName 
FROM booking b
JOIN tblCustomer tc
ON b.custid = tc.CustId
WHERE bookingdate BETWEEN '2018/10/01' AND  '2019/01/31' 
GROUP BY tc.CustId,tc.CustName
HAVING SUM(b.totalAmt) <(SELECT AVG(totalAmt)
						 FROM booking
						 WHERE travelclass = 'business'
						  )


--12.Identify the bookings with travel class ‘Business’ for the International flights.Write a SQL

--query to display booking id, flight id and customer id of those customer(s) not having

--letter ‘e’ anywhere in their name and have booked the identified flight(s).

SELECT bookingid,b.FlightId,b.custid
FROM booking b
JOIN tblFlight tf
ON b.flightid = tf.FlightId
JOIN tblCustomer tc
ON b.custid = tc.CustId
WHERE b.travelclass = 'Business' AND tf.FlightType = 'International' AND tc.CustName NOT LIKE '%e%'



--13.Identify the booking(s) which have flight charges paid is less than the average flight

--charge for all flight ticket bookings belonging to same flight type. Write a SQL query to

--display booking id, source city, destination city and booking date of the identified

--bookings.


SELECT b.bookingid,tf.Source,tf.Destination,b.Bookingdate
FROM booking b
JOIN tblFlight tf
ON b.flightid = tf.FlightId
GROUP BY b.bookingid,tf.Source,tf.Destination,b.Bookingdate
HAVING SUM(b.totalAmt) < (SELECT AVG(b.totalAmt)
FROM booking b
INNER JOIN tblFlight tf
ON b.flightid = tf.FlightId)
