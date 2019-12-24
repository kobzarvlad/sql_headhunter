SELECT resume.resume_id,
	array_agg(specialization_name || ' ') as specialization_array, -- ' ' для легкого различения элементов массива
	MODE() WITHIN GROUP (ORDER BY specialization_name) as most_popular_specialization 
FROM resume 
INNER JOIN response ON resume.resume_id = response.resume_id
INNER JOIN vacancy_specialization ON response.vacancy_id = vacancy_specialization.vacancy_id
INNER JOIN specialization ON vacancy_specialization.specialization_id = specialization.specialization_id
GROUP BY resume.resume_id;
	