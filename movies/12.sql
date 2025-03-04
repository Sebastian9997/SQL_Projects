SELECT movies.title FROM movies
JOIN stars ON movies.id = stars.movie_id
JOIN people ON stars.person_id = people.id
WHERE stars.person_id = (SELECT id FROM people WHERE name = 'Helena Bonham Carter') AND
stars.movie_id IN (SELECT movies.id FROM movies
JOIN stars ON movies.id = stars.movie_id
JOIN people ON stars.person_id = people.id
WHERE stars.person_id = (SELECT id FROM people WHERE name = 'Johnny Depp'));
