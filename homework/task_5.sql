SELECT name FROM 
	vacancy LEFT JOIN response ON vacancy.vacancy_id = response.vacancy_id
	INNER JOIN vacancy_body ON vacancy.vacancy_body_id = vacancy_body.vacancy_body_id
WHERE ((vacancy.creation_time > response.creation_time) AND (vacancy.creation_time - response.creation_time) <= '1 week'::interval) 
	OR response IS NULL
GROUP BY vacancy.vacancy_id, name
HAVING COUNT(vacancy.vacancy_id) < 5
ORDER BY name;