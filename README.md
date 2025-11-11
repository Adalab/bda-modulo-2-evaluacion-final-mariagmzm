# 📊 Evaluación Final Módulo 2: Consultas SQL 

## 📝 Acerca del Proyecto

Este repositorio contiene la resolución de la Evaluación Final del Módulo 2, centrada en la extracción y manipulación de datos utilizando el lenguaje SQL.

Los ejercicios se realizaron sobre la base de datos de ejemplo Sakila, que simula una tienda de alquiler de películas e incluye tablas clave como film, actor, customer, rental, y category.

El objetivo principal fue demostrar la comprensión y el dominio de consultas complejas, incluyendo JOINs, funciones de agregación (COUNT, AVG), agrupamiento (GROUP BY, HAVING), y subconsultas.

## ⚙️ Estructura del Repositorio



- sql.sql : Contiene todas las soluciones a los 24 ejercicios propuestos, estructuradas y comentadas para su fácil seguimiento.

- README.md : Este documento.

## 🚀 Cómo Arrancar el Proyecto

Dado que este proyecto es una colección de scripts SQL, los siguientes pasos son necesarios para "ejecutar" el código:

#### Requisitos Previos

1. Motor de Base de Datos: Necesitas un sistema gestor de bases de datos (DBMS) que soporte SQL (ej. MySQL, PostgreSQL, etc.).

2. Base de Datos Sakila: Debes tener instalada y cargada la base de datos Sakila en tu entorno local.

#### Pasos de Ejecución

1. Abrir el Script: Abre el archivo sql.sql en tu cliente SQL preferido (MySQL Workbench, DBeaver, VS Code con extensiones SQL, etc.).

2. Seleccionar la BD: Asegúrate de que el script comienza con el comando USE sakila; (como ya está incluido en el archivo) o selecciona manualmente la base de datos sakila en tu cliente.

3. Ejecutar Consultas: Ejecuta las consultas individualmente o en bloques. Cada consulta está precedida por su enunciado como comentario para una referencia rápida.

## 💻 Ejercicios Resueltos (Ejemplos de Temas)

El archivo sql.sql cubre una amplia gama de habilidades SQL:

- Consultas Básicas: SELECT DISTINCT, WHERE, LIKE, BETWEEN. 

Ejemplo:

    SELECT actor_id, first_name, last_name
    FROM actor
    WHERE actor_id BETWEEN 10 AND 20
    ORDER BY actor_id ASC;

- Agregación y Agrupamiento: Uso de COUNT(), AVG(), GROUP BY, y la cláusula HAVING.

Ejemplo:

    SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS 'total peliculas' 
    FROM actor AS a 
    INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id
    HAVING COUNT(fa.film_id) >= 10;

- Combinación de Tablas (JOINs): Uso de INNER JOIN y LEFT JOIN para combinar información de customer, rental, film, y actor.

Ejemplo:

    SELECT `c`.`name` AS 'categoría' , COUNT(rental_id) AS 'Total de alquileres'
    FROM category AS c LEFT JOIN film_category AS fc ON c.category_id = fc.category_id
    LEFT JOIN film AS f ON f.film_id = fc.film_id
    LEFT JOIN inventory AS i ON i.film_id = fc.film_id
    LEFT JOIN rental AS r ON r.inventory_id = i.inventory_id
    GROUP BY `c`.`name`

- Subconsultas: Aplicación de subconsultas en cláusulas WHERE (e.g., ejercicios 22 y 23) para lógica de exclusión (NOT IN) y filtrado avanzado.

Ejemplo:
 
    SELECT a.first_name, a.last_name 
    FROM actor AS a
    WHERE actor_id NOT IN (
                        SELECT a.actor_id
						FROM actor AS a
						INNER JOIN  film_actor AS fa ON a.actor_id = fa.actor_id
						INNER JOIN film AS f ON f.film_id = fa.film_id
						INNER JOIN film_category AS fc ON fc.film_id = f.film_id
						INNER JOIN category AS c ON c.category_id = fc.category_id
						WHERE `c`.`name` = 'Horror');   

- Funciones de Fecha: Utilización de DATEDIFF para calcular la duración de los alquileres.

Ejemplo:

    SELECT DISTINCT f.title
    FROM film  AS f
    INNER JOIN inventory AS i ON i.film_id = f.film_id
    WHERE i.inventory_id IN (
                SELECT r.inventory_id
                FROM rental AS r
				WHERE DATEDIFF(return_date, rental_date) > 5);

## 🤝 Contribución

Este repositorio está destinado a ser la entrega final de un ejercicio. Las contribuciones externas no son aplicables.

## 🛡️ Licencia

Este trabajo se presenta para fines educativos y de evaluación

