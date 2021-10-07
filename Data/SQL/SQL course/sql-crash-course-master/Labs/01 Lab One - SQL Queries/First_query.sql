
--1)How many files are in the inventory
SELECT COUNT (*) AS file_count
FROM film

--2)What does a sample input of the film look like?
SELECT *
FROM film
LIMIT 100

-- 3) What files are longer than three hours? Order by title
--reverse alphabetic order
SELECT title, release_year, rental_duration, rating
FROM film
WHERE length >= 180
ORDER BY title DESC

--4) What films are longer than 3 hours and have a rental
--duration of a week order by rating

SELECT title, length/60.0 AS length_in_hours, release_year,
rental_duration, rating
FROM film
WHERE length >= 180 
AND rental_duration = 7
ORDER BY rating 

--5)What are the max and min rental rates of the
--movies in inventory

SELECT MAX(rental_rate) AS max_rate, MIN(rental_rate) AS min_rate
FROM film

--6) What is the average rental rate
SELECT AVG (rental_rate)
FROM film

--7) Find the range of dates in the payment table
SELECT MIN(payment_date), MAX(payment_date)
FROM payment

--8) What customers made a payment in May? Order by date
SELECT c.customer_id, c.first_name, c.last_name, p.payment_date
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
WHERE payment_date >= '20070401'
ORDER BY p.payment_date

--9) What is the average payment by customer? Display results
--by ascending amount.
SELECT c.customer_id, c.first_name, c.last_name, 
AVG (p.amount) AS average_payment
FROM customer c	
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY AVG(p.amount) DESC


