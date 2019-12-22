SELECT most_resumes_month, most_vacancies_month FROM
	(SELECT mon as most_vacancies_month FROM
		(SELECT to_char(creation_time, 'MONTH') as mon,
			    count(*) as number_of_created_vacancies
		FROM vacancy
		GROUP BY mon
		ORDER BY number_of_created_vacancies DESC
		LIMIT 1) as v1) as v2,

	(SELECT mon as most_resumes_month FROM
		(SELECT to_char(creation_time, 'MONTH') as mon,
			    count(*) as number_of_created_resumes
		FROM resume
		GROUP BY mon
		ORDER BY number_of_created_resumes DESC
		LIMIT 1) as r1) as r2;
