CREATE TABLE IF NOT EXISTS resume_log (
	resume_id integer NOT NULL,
	last_change_time timestamp NOT NULL,
	old_row jsonb
);

CREATE OR REPLACE FUNCTION add_to_logs()
RETURNS TRIGGER AS 
$$
	BEGIN
		INSERT INTO resume_log(resume_id, last_change_time, old_row) VALUES 
			(OLD.resume_id, current_timestamp, row_to_json(OLD));
		RETURN NEW;
	END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER update_or_delete_resume_trigger
AFTER UPDATE OR DELETE
ON resume
FOR EACH ROW
EXECUTE PROCEDURE add_to_logs();

--UPDATE resume SET title = '5' WHERE resume_id = 88;
--DELETE FROM resume WHERE resume_id = 100;

SELECT resume_log.resume_id,  
	last_change_time,
	old_row::json->'title' as old_title,
	LAG(old_row::json->'title', -1, to_json(resume.title)) OVER 
	(PARTITION BY resume_log.resume_id ORDER BY resume_log.last_change_time) as new_title
FROM resume_log LEFT JOIN resume ON resume_log.resume_id = resume.resume_id;







