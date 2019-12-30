SELECT s1.resume_id, specializations_array, most_popular_spec_in_vacancies
FROM
	(SELECT resume.resume_id,
		array_agg(resume_specialization.specialization_id) as specializations_array
	FROM
		resume INNER JOIN resume_specialization ON resume.resume_id = resume_specialization.resume_id
	GROUP BY resume.resume_id) as s1

	INNER JOIN

	(SELECT resume.resume_id,
		MODE() WITHIN GROUP (ORDER BY vacancy_specialization.specialization_id) as most_popular_spec_in_vacancies
	FROM
		resume LEFT JOIN response ON resume.resume_id = response.resume_id
		LEFT JOIN vacancy_specialization ON response.vacancy_id = vacancy_specialization.vacancy_id
	GROUP BY resume.resume_id) as s2 ON s1.resume_id = s2.resume_id;
	