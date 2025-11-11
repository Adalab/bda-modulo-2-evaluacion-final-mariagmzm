USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT DISTINCT title
FROM film;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT *
FROM film;

SELECT title, rating
FROM film
WHERE rating = 'PG-13';

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

SELECT title, `description` -- ponemos las comillas ya que es un comando especial de sql y necesitamos que sea una columna para una consulta
FROM film
WHERE `description` LIKE '%amazing%'; -- si lo ponemos entre dos % nos aseguramos que lo busque en cualquier posicion


-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos

SELECT title, `length` -- lo volvemos a poner entre comillas porque lenght tambien puede ser una funcion
FROM film 
WHERE `length` > 120;

-- 5. Recupera los nombres de todos los actores.

SELECT first_name, last_name
FROM actor;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

SELECT first_name, last_name
FROM actor
WHERE last_name = 'Gibson';

-- 7.Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20
ORDER BY actor_id ASC;

-- 8.Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación

SELECT title, rating
FROM film
WHERE rating NOT IN ('R','PG-13');

-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento

SELECT rating, COUNT(title)
FROM film
GROUP BY rating;

-- 10.Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido
-- junto con la cantidad de películas alquiladas

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) -- esta seria la respuesta que enseñe solo los clientes que han alquilado alguna pelicula
FROM customer AS c
INNER JOIN rental AS r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) -- esta seria la respuesta que enseñe todos los clientes, incluso los que no han alquilado nada
FROM customer AS c
LEFT JOIN rental AS r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
-- junto con el recuento de alquileres.

SELECT *
FROM film_category;

SELECT *
FROM category;

SELECT `c`.`name` , COUNT(rental_id)
FROM category AS c LEFT JOIN film_category AS fc ON c.category_id = fc.category_id
LEFT JOIN film AS f ON f.film_id = fc.film_id
LEFT JOIN inventory AS i ON i.film_id = fc.film_id
LEFT JOIN rental AS r ON r.inventory_id = i.inventory_id
GROUP BY `c`.`name`; 

-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
-- muestra la clasificación junto con el promedio de duración

SELECT *
FROM film;

SELECT rating, AVG(`length`)
FROM film
GROUP BY rating;

SELECT COUNT(DISTINCT rating) -- esta es solo una consulta de comprobacion para saber cuantas clasificaciones distintas tenemos
FROM film;

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

SELECT a.first_name, a.last_name, f.title -- buscamos f.title para comprobar que efectivamente, son los actores de la pelicula que buscamos
FROM actor AS a 
INNER JOIN film_actor AS fa ON fa.actor_id = a.actor_id
INNER JOIN film AS f ON f.film_id = fa.film_id
WHERE title = 'Indian Love';

SELECT a.first_name, a.last_name -- esta seria la consulta tal cual nos la han pedido
FROM actor AS a 
INNER JOIN film_actor AS fa ON fa.actor_id = a.actor_id
INNER JOIN film AS f ON f.film_id = fa.film_id
WHERE title = 'Indian Love';

-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT title, `description`
FROM film 
WHERE `description` LIKE '%dog%' OR `description` LIKE '%cat%'; 

-- 15.Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.

SELECT DISTINCT actor_id -- primero consulto los distintos id de los actores, ya que al hacer la primera consulta sin el distinct, me salian varias veces el mismo id
FROM film_actor;

SELECT first_name, last_name
FROM actor 
WHERE actor_id NOT IN (
                      SELECT DISTINCT actor_id  
                      FROM film_actor);
			
SELECT DISTINCT actor_id  -- Ultima consulta para ver que no haya ningun valor nulo
FROM film_actor
WHERE actor_id IS NULL;


-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

