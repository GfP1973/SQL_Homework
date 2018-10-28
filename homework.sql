Use sakila;
-- 1a select names from table
select actor.first_name, actor.last_name
FROM actor;

-- 1b

select Concat(actor.first_name, ' ', actor.last_name) As "Actor Name"
from actor;

-- 2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = "JOE";

-- 2b
SELECT first_name, last_name
From actor
WHERE last_name like '%GEN%';

-- 2c
Select last_name, first_name
from actor
WHERE last_name like '%LI%';

-- 2d

SELECT country_id, country
From country
where country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a

ALTER TABLE actor
Add Column Description BLOB Not Null;

-- 3b
ALTER TABLE actor
DROP Column Description;

-- 4a

SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name;

-- 4b

SELECT last_name, COUNT(last_name) AS 'COUNTS'
FROM actor
GROUP BY last_name
HAVING COUNTS > 2;

-- 4c

UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" And last_name = "WILLIAMS";

-- 4d

UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO" And last_name = "WILLIAMS";

-- 5a

SHOW CREATE TABLE address;

-- 6a

SELECT staff.first_name, staff.last_name, address.address
from staff
INNER JOIN address ON
staff.address_id = address.address_id;

-- 6b

SELECT staff.first_name, staff.last_name, SUM(payment.amount)
from staff
INNER JOIN payment ON
staff.staff_id = payment.staff_id;

-- 6c

SELECT film.title, count(actor_id)
from film
inner join film_actor On
film.film_id = film_actor.film_id
Group BY film.title;

-- 6d

Select film.title, count(inventory.film_id)
from film
inner join inventory on
film.film_id = inventory.film_id
where film.title = 'Hunchback Impossible';

-- 6e

SELECT customer.first_name, customer.last_name, sum(payment.amount)
from customer
inner join payment on
customer.customer_id = payment.customer_id
GROUP BY customer.last_name
ORDER BY customer.last_name ASC;

-- 7a

Select title 
from film
where title like 'Q%' and language_id = 1
UNION
Select title 
from film
where title like 'K%' and language_id = 1
;
	
-- 7b

Select first_name, last_name
from actor
where actor_id 
	in (
		Select actor_id
        from film_actor
        where film_id
         in (
			Select film_id
            from film
            where title = 'Alone Trip'
            )
		);
 
 

-- 7c

select first_name, last_name, email
from customer as a
inner join address on a.address_id = address.address_id
inner join city on city.city_id = address.city_id
inner join country on country.country_id = city.country_id
where country.country = 'Canada';

-- 7d
        
use sakila;
-- select * from category;
select title
from film as f
inner join film_category on f.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
where name = "Family";

-- 7e 

select * from rental;

Select title, count(rental.inventory_id) as "Rental Count" 
from film as f
inner join inventory on f.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
GROUP BY title
Order BY count(rental.inventory_id) desc;


-- 7f Query store sales

select s.store_id as "Store Number", sum(payment.amount) as "Total Sales in $"
from store as s
inner join staff on s.store_id = staff.store_id
inner join payment on staff.staff_id = payment.staff_id
Group BY s.store_id;

-- 7g

Select s.store_id, city.city, country.country
from store as s
inner join address on s.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
Group by s.store_id;

-- 7h


select category.name, sum(payment.amount) as "Gross Revenue in $"
from category
inner join film_category on category.category_id = film_category.category_id
inner join inventory on film_category.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
inner join payment on rental.rental_id = payment.rental_id
GROUP By category.name
order by sum(payment.amount) desc limit 5;
		
-- 8a

Create View Top_Gross_Categories as
select category.name, sum(payment.amount) as "Gross Revenue in $"
from category
inner join film_category on category.category_id = film_category.category_id
inner join inventory on film_category.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
inner join payment on rental.rental_id = payment.rental_id
GROUP By category.name
order by sum(payment.amount) desc limit 5;

-- 8b
select * from Top_Gross_Categories;

-- 8c
Drop view Top_Gross_Categories;

-- End of line.



