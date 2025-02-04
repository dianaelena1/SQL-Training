SELECT 
*
FROM movies

JOIN movie_actor ON movies.id = movie_actor.movie_id;

JOIN actors ON movie_actor.actor_id = actors.actor_id;

SELECT 
movies.titlu AS Titlu, 
movies.actori AS Actori, 
movies.locatie AS Locatie,
actors.first_name AS Actor, 
actors.last_name AS actorLast, 
actors.birth_date AS dateOfBirth

FROM movies

JOIN movie_actor ON movies.id = movie_actor.movie_id;

JOIN actors ON movie_actor.actor_id = actors.actor_id;