CREATE DATABASE SAMPLE;


CREATE TABLE tbldirectors(
	director_id SERIAL PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(4) NOT NULL
)

SELECT * FROM tbldirectors

ALTER TABLE tbldirectors
ALTER column last_name TYPE VARCHAR(20)

CREATE TABLE tblmovies(
	movie_id SERIAL PRIMARY KEY,
	movie_name VARCHAR(100) NOT NULL,
	movie_length INT NOT NULL,
	movie_lang VARCHAR(20) NOT NULL,
	movie_Certificate VARCHAR(3) NOT NULL,
	movie_date DATE NOT NULL,
	director_id INT ,
	
	FOREIGN KEY(director_id) REFERENCES tbldirectors(director_id)
);

CREATE TABLE tblactors(
	actor_id SERIAL PRIMARY KEY,
	first_name VARCHAR(150) NOT NULL,
	Last_name VARCHAR(150) NOT NULL,
	gender CHAR(1),
	date_of_birth DATE NOT NULL,
	movie_id INT,
	FOREIGN KEY(movie_id) REFERENCES tblmovies(movie_id)
);


CREATE PROCEDURE inser(f_name VARCHAR(20),L_name VARCHAR(20))
LANGUAGE plpgsql
AS $$

BEGIN
INSERT INTO tbldirectors(first_name,last_name) VALUES(f_name,L_name);
END
$$

call inser('Sandhya', 'Shree')


INSERT INTO tblmovies( movie_name, movie_length, movie_lang, movie_certificate, movie_date, 
director_id) VALUES ('3 ediots', 220, 'Hindi', 'B', '2008-11-08', 1)


INSERT INTO tblmovies( movie_name, movie_length, movie_lang, movie_certificate, movie_date, 
director_id) VALUES ( 'Mersal', 250, 'Tamil', 'B', '2023-10-08', 2)

INSERT INTO tblmovies( movie_name, movie_length, movie_lang, movie_certificate, movie_date, 
director_id) VALUES ('Ghili', 250, 'Tamil', 'B', '2023-09-08', 3)

INSERT INTO tblmovies( movie_name, movie_length, movie_lang, movie_certificate, movie_date, 
director_id) VALUES ('Master', 250, 'Tamil', 'B', '2023-08-08', 4)

INSERT INTO tblmovies( movie_name, movie_length, movie_lang, movie_certificate, movie_date, 
director_id) VALUES ('Bigil', 250, 'Tamil', 'B', '2023-07-08', 5)

INSERT INTO tblmovies( movie_name, movie_length, movie_lang, movie_certificate, movie_date, 
director_id) VALUES ( 'Thuppakki', 250, 'Tamil', 'B', '2023-06-08', 6)


INSERT INTO tblmovies( movie_name, movie_length, movie_lang, movie_certificate, movie_date, 
director_id) VALUES ('Kushi', 250, 'Tamil', 'B', '2023-04-08', 1)

INSERT INTO tblmovies( movie_name, movie_length, movie_lang, movie_certificate, movie_date, 
director_id) VALUES ('Thalaivaa', 250, 'Tamil', 'B', '2023-03-08', 2)

INSERT INTO tblmovies( movie_name, movie_length, movie_lang, movie_certificate, movie_date, director_id) VALUES 
('Nanban', 250, 'Tamil', 'B', '2023-02-08', 3);



INSERT INTO tblactors(  first_name, last_name, gender, date_of_birth, movie_id) 
VALUES     
( 'Joshna', 'John', 'F', '1989-11-08', 1); 

SELECT * FROM tblactors

SELECT * FROM tbldirectors

SELECT * FROM tblmovies

/*1.Display Movie name, movie language and release date from movies table. */

SELECT tblmovies.movie_name,tblmovies.movie_lang
FROM tblmovies

/*2.Display only 'Kannada' movies from movies table. */
SELECT *
FROM tblmovies
WHERE movie_lang ILIKE 'kannada'

/*3.Display movies released before 1st Jan 2011. */

SELECT * 
FROM tblmovies 
WHERE movie_date < '2023-4-08'


/*4.Display Hindi movies with movie duration more than 150 minutes.*/

SELECT *
FROM tblmovies
WHERE movie_lang = 'Hindi' AND movie_length > 150


/*5.Display movies of director id 3 or Kannada language. */

SELECT *
FROM tblmovies
WHERE director_id = 3 OR movie_lang = 'kannada'


/*6.Display movies released in the year 2023. */

SELECT *
FROM tblmovies
WHERE EXTRACT (YEAR FROM(movie_date)) = 2023


/*7.Display movies that can be watched below 15 years.*/

SELECT *
FROM tblmovies
WHERE movie_certificate = 'B'

/*8.Display movies that are released after the year 2015 and directed by directorid 3. */

SELECT *
FROM tblmovies
WHERE EXTRACT(YEAR FROM(movie_date)) > 2015 AND director_id = 3


/*9.Display all other language movies except Hindi language. */

SELECT * 
FROM tblmovies
WHERE tblmovies.movie_lang != 'Hindi';

-- 10.Display movies whose language name ends with 'u'. 
SELECT * 
FROM tblmovies
WHERE tblmovies.movie_lang ~~* '%u';

-- 11.Display movies whose language starts with 'm'.

SELECT * 
FROM tblmovies
WHERE tblmovies.movie_lang ~~* 'm%';

-- 12.Display movies with language name that has only 5 characters. 

SELECT * 
FROM tblmovies
WHERE tblmovies.movie_lang LIKE '_____';

-- 13.Display the actors who were born before the year 1980. 
SELECT *
FROM tblactors
WHERE EXTRACT(YEAR FROM date_of_birth) < 1980


-- 14.Display the youngest actor from the actors table. 
SELECT *
FROM tblactors
ORDER BY date_of_birth DESC
FETCH FIRST ROW WITH TIES

-- 15.Display the oldest actor from the actors table. 
SELECT *
FROM tblactors
ORDER BY date_of_birth 
FETCH FIRST ROW WITH TIES

-- 16.Display all the female actresses whose ages are between 30 and 35. 
SELECT *
FROM tblactors
WHERE gender = 'F' AND (EXTRACT(YEAR FROM Current_date) - EXTRACT(YEAR FROM date_of_birth)) BETWEEN 30 AND 35
-- 17.Display the actors whose movie ids are in 1 to 5. 
SELECT *
FROM tblactors
WHERE movie_id BETWEEN 1 AND 5
-- 18.Display the longest duration movie from movies table. 
SELECT *
FROM tblmovies
WHERE movie_length = (SELECT MAX(movie_length)
					  FROM tblmovies)

-- 19.Display the shortest duration movie from movies table. 
SELECT *
FROM tblmovies
WHERE movie_length = (SELECT MIN(movie_length)
					  FROM tblmovies)


-- 20.Display the actors whose name starts with vowels.
SELECT *
FROM tblactors
WHERE LEFT((tblactors.first_name),1) IN ('A','E','I','O','U')

-- OR
SELECT *
FROM tblactors
WHERE tblactors.first_name ~* '^[a|e|i|o|u].*$';

-- 21.Display all the records from tblactors by sorting 
-- the data based on the fist_name in the 
-- ascending order and date of birth in the descending order. 
SELECT *
FROM tblactors
ORDER BY tblactors.first_name ASC,tblactors.date_of_birth DESC

-- 22.Write a query to  return the data related to movies 
-- by arranging the data in ascending order 
-- based on the movie_id and also fetch the data from the 
-- fifth value to the twentieth value. 

SELECT *
FROM tblmovies
ORDER BY tblmovies.movie_id ASC
OFFSET 5
FETCH FIRST 20 ROWS ONLY
 
 
CREATE OR REPLACE PROCEDURE Adds(IN num1 INT,INOUT num2 INT)--, OUT res INT )
LANGUAGE plpgsql
AS
$$
BEGIN
num2 := num1 + num2;

-- SELECT num1+num2 INTO num2;
return;
END
$$

DO $$
	DECLARE resul INTEGER;
BEGIN
	CALL Adds(1,5);
	RAISE NOTICE '%',resul;
END $$

DECLARE resul INTEGER
CALL Adds(1,5)

SELECT (5,6)

CREATE TABLE orders (
	id serial NOT NULL PRIMARY KEY,
	info json NOT NULL
);

INSERT INTO orders (info)
VALUES('{ "customer": "Lily Bush", "items": {"product": "Diaper","qty": 24}}'),
      ('{ "customer": "Josh William", "items": {"product": "Toy Car","qty": 1}}'),
      ('{ "customer": "Mary Clark", "items": {"product": "Toy Train","qty": 2}}');
	  
SELECT info -> 'items' ->> 'product' 
FROM orders
WHERE CAST(info -> 'items' ->> 'qty' AS INTEGER) >=2