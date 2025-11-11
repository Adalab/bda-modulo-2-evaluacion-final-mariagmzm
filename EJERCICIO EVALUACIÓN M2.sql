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

SELECT title, release_year
FROM film 
WHERE release_year BETWEEN 2005 AND 2010;

-- 17.Encuentra el título de todas las películas que son de la misma categoría que "Family"

SELECT f.title, `c`.`name`
FROM film AS f
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
INNER JOIN category AS c ON c.category_id = fc.category_id
WHERE `c`.`name` = 'Family';

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas

SELECT *  -- primera consulta para ver como se relacionan las tablas
FROM film_actor;
 
SELECT a.first_name, a.last_name, fa.film_id -- consulta para ver los nombres y los id de las peliculas que han hecho cada uno
FROM actor AS a 
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id; 


SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS 'total peliculas' -- con esta consulta averiguamos cuantas peliculas ha hecho cada uno en total
FROM actor AS a                                                          
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id; -- agrupandolos por actor no nos hace falta poner un distinc

SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS 'total peliculas' -- ultima consulta para filtrar los que tienen mas de 10 peliculas
FROM actor AS a 
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING COUNT(fa.film_id) >= 10;

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film

SELECT title, `length` -- primera consulta para averiguar las peliculas que duran mas de 2 horas(120min)
FROM film  
WHERE `length` > 120;

SELECT title, `length`, rating
FROM film
WHERE rating = 'R' AND `length` > 120;

-- 20.Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
-- muestra el nombre de la categoría junto con el promedio de duración

SELECT AVG(`length`) -- primera consulta para ver la duracion promedio
FROM film;

SELECT `c`.`name`, AVG(`length`) AS 'Duración promedio' -- a la hora de hacer la consulta,hay que poner aqui la funcion de agregacion
FROM category AS c
INNER JOIN film_category AS fc ON c.category_id = fc.category_id
INNER JOIN film AS f ON fc.film_id = f.film_id
GROUP BY `c`.`name` -- agrupamos por nombre
HAVING AVG(`length`) > 120; -- especificamos que buscamos los que tienen mas de 120min

-- 21.Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
-- con la cantidad de películas en las que han actuado.

SELECT a.first_name, a.last_name, COUNT(f.film_id) AS 'Cantidad de peliculas'
FROM actor AS a
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
INNER JOIN film AS f ON fa.film_id = f.film_id
GROUP BY a.actor_id -- agrupamos por id de actor
HAVING COUNT(f.film_id) >= 5; -- le pedimos que nos enseñe los que tienen mas de 5 peliculas

-- 22.Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
-- subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
-- películas correspondientes.

SELECT rental_id
FROM rental
WHERE DATEDIFF(return_date, rental_date) > 5 ;

SELECT DISTINCT f.title
FROM film  AS f
INNER JOIN inventory AS i ON i.film_id = f.film_id
WHERE i.inventory_id IN (SELECT r.inventory_id -- aqui cambiamos inventory_id ya que queremos que nos devuelva el id de las copias que se han alquilado 
                FROM rental AS r
				WHERE DATEDIFF(return_date, rental_date) > 5);

-- 23.Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
-- "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
-- categoría "Horror" y luego exclúyelos de la lista de actores.

SELECT a.actor_id
FROM actor AS a
INNER JOIN  film_actor AS fa ON a.actor_id = fa.actor_id
INNER JOIN film AS f ON f.film_id = fa.film_id
INNER JOIN film_category AS fc ON fc.film_id = f.film_id
INNER JOIN category AS c ON c.category_id = fc.category_id
WHERE `c`.`name` = 'Horror';

SELECT a.first_name, a.last_name
FROM actor AS a
WHERE actor_id NOT IN (SELECT a.actor_id
FROM actor AS a
INNER JOIN  film_actor AS fa ON a.actor_id = fa.actor_id
INNER JOIN film AS f ON f.film_id = fa.film_id
INNER JOIN film_category AS fc ON fc.film_id = f.film_id
INNER JOIN category AS c ON c.category_id = fc.category_id
WHERE `c`.`name` = 'Horror');


-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.









                                      




