SELECT vacancy_name FROM
	(SELECT vacancy_body.name as vacancy_name,
		   	count(*) as cnt
	FROM
		vacancy LEFT JOIN response ON vacancy.vacancy_id = response.vacancy_id
		INNER JOIN vacancy_body ON vacancy.vacancy_body_id = vacancy_body.vacancy_body_id
	WHERE ((vacancy.creation_time > response.creation_time) AND (vacancy.creation_time - response.creation_time) <= '1 week'::interval)
	 	  OR (vacancy.vacancy_id NOT IN (SELECT vacancy_id FROM response))
	GROUP BY vacancy.vacancy_id, vacancy_body.name
	ORDER BY cnt) as v
WHERE cnt < 5
ORDER BY vacancy_name;