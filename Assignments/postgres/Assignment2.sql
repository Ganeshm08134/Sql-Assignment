--1. List the different languages of movies. 
	SELECT DISTINCT(movie_lang)
	FROM tblmovies

-- 2.Display the unique first names of all directors in ascending order by 
-- their first name and then for each group of duplicates, keep the first row in the 
-- returned result set. 
	SELECT DISTINCT ON (first_name)first_name,last_name
	FROM tbldirectors
	ORDER BY first_name ASC
 
-- 3. write a query to retrieve 4 records starting from the fourth one, to 
-- display the actor ID, name (first_name, last_name) and date of birth, and 
-- arrange the result as Bottom N rows from the actors table according to their 
-- date of birth.   
 	SELECT actor_id,(first_name||' '||last_name) AS Name,date_of_birth
	FROM tblactors
	ORDER BY date_of_birth DESC
	OFFSET 3
	LIMIT 4
	
-- 4.Write a query to get the first names of the directors who holds the letter 
-- 'S' or 'J' in the first name. 
	SELECT first_name
	FROM tbldirectors
	WHERE LEFT(first_name,1) ~* '^.*[s|j].*$'
 
-- 5.Write a query to find the movie name and language of the movie of all 
-- the movies where the director name is Joshna. 
	

	SELECT 
	FROM tblmovies
	WHERE director_id = (SELECT director_id 
						 FROM tbldirectors
						 WHERE first_name = 'Joshna')
 
-- Module 8: 
 SELECT LENGTH(' HELLO HAI ')
 SELECT POSITION('l' IN 'Hello')
 SELECT CONCAT_WS(' | ','Hello','hii')
-- 6.Write a query to find the number of directors available in the movies 
-- table. 
	 SELECT COUNT(tblmovies.director_id)
	 FROM tblmovies
-- 7. Write a query to find the total length of the movies available in the 
-- movies table. 
 	SELECT SUM(movie_length)
	FROM tblmovies
-- 8.Write a query to get the average of movie length for all the directors 
-- who are working for more than 1 movie. 
	SELECT director_id,ROUND(AVG(movie_length))
	FROM tblmovies
	GROUP BY director_id
	HAVING COUNT(director_id) > 1
 
-- 9.Write a query to find the age of the actor vijay for the year 2001-04-10. 
     SELECT age(CURRENT_DATE,'2001-04-10')
	 
	 
-- 10.Write a query to fetch the week of this release date 2020-10-10 
-- 13:00:10. 
	 SELECT EXTRACT(WEEK FROM TIMESTAMP '2020-10-10:13:00:10') 
-- 11.Write a query to fetch the day of the week and year for this release date 
-- 2020-10-10 13:00:10.        
 	SELECT CONCAT(TO_CHAR(TIMESTAMP '2020-10-10:13:00:10','DAY'),'-',EXTRACT(YEAR FROM TIMESTAMP '2020-10-10:13:00:10')) 
-- 12.Write a query to convert the given string '20201114' into date and time. 
    SELECT CAST('20201114' AS DATE)
-- 13.Display Today's date. 
    SELECT CURRENT_DATE             
-- 14.Display Today's date with time. 
 	SELECT NOW()
-- 15.Write a query to add 10 Days 1 Hour 15 Minutes to the current date. 
    SELECT CURRENT_DATE + INTERVAL '10 Days 1 Hour 15 Minutes'
	
-- 16.Write a query to find the details of those actors who contain eight or 
-- more characters in their first name. 
	SELECT first_name 
	FROM tbldirectors
	WHERE LENGTH(first_name) >= 8
 
-- 17.Write a query to join the text 'movie' with the movie_name column. 
	SELECT movie_name ||' '||'movie'
	FROM tblmovies
 
-- 18.Write a query to get the actor id, first name and birthday month of an 
-- actor. 
	SELECT actor_id,first_name,EXTRACT(MONTH FROM date_of_birth) 
	FROM tblactors
	
-- 19.Write a query to get the actor id, last name to discard the last three 
-- characters. 
	SELECT actor_id,LEFT(last_name,-3)
	FROM tblactors
 
-- 20.Write a query that displays the first name and the character length of 
-- the first name for all directors whose name starts with the letters 'A', 'J' or 'V'. 
-- Give each column an appropriate label. Sort the results by the directors' first 
-- names. 
 	SELECT first_name
	FROM tblactors
	WHERE LEFT(first_name,1) ~* '[a|j|v]*';
	
-- 21.Write a query to display the first word in the movie name if the movie 
-- name contains more than one words. 
 	SELECT SPLIT_PART(movie_name,' ',1)
	FROM tblmovies
	WHERE  movie_name LIKE '% %'
-- Module 9: 
SELECT *
FROM tblmovies
 
-- 22.Write a query to display the actors name with movie name.       
 	SELECT first_name||' '||last_name||' Acted ON '||movie_name
	FROM tblmovies tm
	INNER JOIN tblactors ta
	ON tm.movie_id = ta.movie_id
-- 23.Write a query to make a join with three tables movies, actors, and 
-- directors to display the movie name, director name, and actors date of birth. 
 	SELECT * FROM tblmovies
	
	SELECT movie_name,(td.first_name||' '||td.last_name) AS director_name,date_of_birth
	FROM tbldirectors td
	INNER JOIN tblmovies tm
	ON td.director_id = tm.director_id
	INNER JOIN tblactors ta
	ON tm.movie_id  = ta.movie_id
-- 24.Write a query to make a join with two tables directors and movies to 
-- display the status of directors who is currently working for the movies above 
-- 1. 
	SELECT *
 	FROM tbldirectors td
	INNER JOIN tblmovies tm
	ON td.director_id = tm.director_id
 
-- 25.Write a query to make a join with two tables movies and actors to get 
-- the movie name and number of actors working in each movie.
	SELECT movie_name,COUNT(actor_id)
	FROM tblmovies tm
 	INNER JOIN tblactors ta
	ON tm.movie_id  = ta.movie_id
	GROUP BY movie_name
 
-- 26.Write a query to display actor id, actors name (first_name, last_name)  
-- and movie name to match ALL records from the movies table with each 
-- record from the actors table.
	SELECT actor_id,(ta.first_name||' '||ta.last_name) AS actor_name,movie_name
	FROM tblactors ta
	INNER JOIN tblmovies tm
	ON ta.movie_id = tm.movie_id