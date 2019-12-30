CREATE TABLE IF NOT EXISTS vacancy_body (
	vacancy_body_id serial PRIMARY KEY,
	company_name varchar(150) DEFAULT ''::varchar NOT NULL,
	name varchar(220) DEFAULT ''::varchar NOT NULL,
	text text,
	area_id integer,
	address_id integer,
	work_experience integer DEFAULT 0 NOT NULL,
	compensation_from bigint DEFAULT 0,
	compensation_to bigint DEFAULT 0,
	test_solution_required boolean DEFAULT false NOT NULL,
	work_schedule_type integer DEFAULT 0 NOT NULL,
	employment_type integer DEFAULT 0 NOT NULL,
	compensation_gross boolean,
	CONSTRAINT vacancy_body_work_employment_type_validate CHECK
((employment_type = ANY (ARRAY[0, 1, 2, 3, 4]))),
	CONSTRAINT vacancy_body_work_schedule_type_validate CHECK
((work_schedule_type = ANY (ARRAY[0, 1, 2, 3, 4])))
);

CREATE TABLE IF NOT EXISTS vacancy (
	vacancy_id serial PRIMARY KEY,
	creation_time timestamp NOT NULL,
	expire_time timestamp NOT NULL,
	employer_id integer DEFAULT 0 NOT NULL,
	active boolean DEFAULT true NOT NULL,
	visible boolean DEFAULT true NOT NULL,
	vacancy_body_id integer,
	area_id integer
);

CREATE TABLE IF NOT EXISTS resume_body (
	resume_body_id serial PRIMARY KEY,
	compensation bigint DEFAULT 0,
	is_male boolean NOT NULL,
	age integer NOT NULL,
	date_of_birth DATE NOT NULL,
	area_id integer,
	ready_to_relocate boolean NOT NULL,
	ready_for_business_trip boolean NOT NULL, 
	employment_type integer DEFAULT 0 NOT NULL,
	work_schedule_type integer DEFAULT 0 NOT NULL,
	text text,
	work_experience integer DEFAULT 0 NOT NULL,
	CONSTRAINT vacancy_body_work_employment_type_validate CHECK
((employment_type = ANY (ARRAY[0, 1, 2, 3, 4]))),
	CONSTRAINT vacancy_body_work_schedule_type_validate CHECK
((work_schedule_type = ANY (ARRAY[0, 1, 2, 3, 4])))
);

CREATE TABLE IF NOT EXISTS resume (
	resume_id serial PRIMARY KEY,
	title varchar(220) DEFAULT ''::varchar NOT NULL,
	creation_time timestamp NOT NULL,
	jobseeker_id integer,
	area_id integer,
	active boolean DEFAULT true NOT NULL,
	resume_body_id integer
);

CREATE TABLE IF NOT EXISTS specialization (
	specialization_id serial PRIMARY KEY,
	specialization_name varchar(220) DEFAULT ''::varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS resume_specialization (
	specialization_id integer,
	resume_id integer
);

CREATE TABLE IF NOT EXISTS vacancy_specialization (
	specialization_id integer,
	vacancy_id integer
);

CREATE TABLE IF NOT EXISTS response (
	response_id serial PRIMARY KEY,
	resume_id integer,
	vacancy_id integer,
	creation_time timestamp
); 