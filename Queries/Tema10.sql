SELECT movies.title AS film, actors.name AS actor
FROM movies
JOIN movie_actors ON movies.movie_id = movie_actors.movie_id
JOIN actors ON movie_actors.actor_id = actors.actor_id
WHERE movies.title LIKE '%nume_film%'
   OR actors.name LIKE '%nume_actor%';
