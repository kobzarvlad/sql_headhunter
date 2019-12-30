-- vacancy
INSERT INTO vacancy(creation_time, expire_time, employer_id, active, visible, vacancy_body_id, area_id)
	SELECT
		'2015-01-01'::timestamp + (random() * 365 * 24 * 3600 * 1) * '1 second'::interval AS creation_time,
		'2018-01-01'::timestamp + (random() * 365 * 24 * 3600 * 1) * '1 second'::interval AS expire_time,		      
		((random() * 10000)::integer + 1) AS employer_id,
		(random() > 0.5) AS active,
		(random() > 0.5) AS visible,
		10000 - i + 1 AS vacancy_body_id,
		((random() *  1000)::integer + 1) AS area_id
	FROM generate_series(1, 10000) as g(i);
	
-- vacancy_body
INSERT INTO vacancy_body(company_name, name, text, area_id, address_id, 
						 work_experience, test_solution_required,
						 work_schedule_type, employment_type, compensation_gross)
	SELECT
		(SELECT string_agg(
			substr(
				'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
				(random() * 61)::integer + 1, 1), '')
		FROM generate_series(1, (random() * 140)::integer + i % 10 + 1)) AS company_name,
		
		(SELECT string_agg(
			substr(
				'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
				(random() * 61)::integer + 1, 1),'')
		FROM generate_series(1, (random() * 210)::integer + i % 10 + 1)) AS name,
		
		(SELECT string_agg(
			substr(
				'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 
				(random() * 61)::integer + 1, 1),'')
		FROM generate_series(1, (random() * 500)::integer + i % 10 + 1)) AS text,
		
		((random() * 1000)::integer + 1) AS area_id,
		((random() * 1000)::integer + 1) AS address_id,
		((random() * 20)::integer) AS work_experience,
		(random() > 0.5) AS test_solution_required,
		floor(random() * 5)::int AS work_schedule_type,
		floor(random() * 5)::int AS employment_type,
		(random() > 0.5) AS compensation_gross
	FROM generate_series(1, 10000) AS g(i);
	
UPDATE vacancy_body 
	SET compensation_from = 20000 + (random() * 30000)::integer
WHERE (vacancy_body_id % 2) = 0;

UPDATE vacancy_body 
	SET compensation_to = 70000 + (random() * 30000)::integer
WHERE (vacancy_body_id % 7) = 0;

UPDATE vacancy_body 
	SET compensation_from = 20000 + (random() * 30000)::integer, compensation_to = 70000 + (random() * 30000)::integer
WHERE (vacancy_body_id % 5) = 0;

-- resume
INSERT INTO resume(creation_time, jobseeker_id, area_id, active, title)
	SELECT
		'2015-01-01'::timestamp + (random() * 365 * 24 * 3600 * 1) * '1 second'::interval AS creation_time,
		((random() * 99999)::integer + 1) AS jobseeker_id,
		((random() * 1000)::integer + 1) AS area_id,
		(random() > 0.5) AS active,
		(SELECT string_agg(
			substr(
				'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
				(random() * 61)::integer + 1, 1),'')
		FROM generate_series(1, (random() * 210)::integer + i % 10 + 1)) AS title
	FROM generate_series(1, 100000) AS g(i);
		

-- response
INSERT INTO response(resume_id, vacancy_id, creation_time)
	SELECT 
		((random() * 5000)::integer + 1) AS resume_id,
		((random() * 1000)::integer + 1) AS vacancy_id,
		'2015-01-01'::timestamp + (random() * 365 * 24 * 3600 * 1) * '1 second'::interval AS creation_time
	FROM generate_series(1, 40000);
	
-- specialization
INSERT INTO specialization(specialization_name)
	SELECT
		(SELECT string_agg(
			substr(
				'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
				(random() * 61)::integer + 1, 1),'')
		FROM generate_series(1, (random() * 210)::integer + i % 10 + 1)) AS specialization_name
	FROM generate_series(1, 5000) as g(i);

-- resume_specialization
INSERT INTO resume_specialization(resume_id, specialization_id)
	SELECT
		i AS resume_id,
		((random() * 4999)::integer + 1) AS specialization_id
	FROM generate_series(1, 100000) as g(i);
INSERT INTO resume_specialization(resume_id, specialization_id)
	SELECT
		i AS resume_id,
		((random() * 4999)::integer + 1) AS specialization_id
	FROM generate_series(1, 100000) as g(i);

-- vacancy_specialization
INSERT INTO vacancy_specialization(vacancy_id, specialization_id)
	SELECT
		i AS vacancy_id,
		((random() * 4999)::integer + 1) AS specialization_id
	FROM generate_series(1, 10000) as g(i);
INSERT INTO vacancy_specialization(vacancy_id, specialization_id)
	SELECT
		i AS vacancy_id,
		((random() * 4999)::integer + 1) AS specialization_id
	FROM generate_series(1, 10000) as g(i);

