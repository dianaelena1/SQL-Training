SELECT *
FROM actors
WHERE birth_date = '2000-01-01'
AND first_name = 'Diana';

UPDATE actors
SET birth_date = '2000-01-01'
WHERE actor_id = 4;