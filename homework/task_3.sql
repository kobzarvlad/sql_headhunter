SELECT area_id, 
	   avg_comp_from, 
	   avg_comp_to, 
	   AVG((avg_comp_from + avg_comp_to) / 2) as avg_mid_comp
FROM
	(SELECT area_id,
	 	    AVG(
				CASE
					WHEN compensation_from <> 0 THEN
						CASE
							WHEN compensation_gross THEN compensation_from * 0.87
							ELSE compensation_from
						END
				END) as avg_comp_from,
	 		AVG(
				CASE
					WHEN compensation_to <> 0 THEN
						CASE
							WHEN compensation_gross THEN compensation_to * 0.87
							ELSE compensation_to
						END
				END) as avg_comp_to
	FROM vacancy_body
	GROUP BY area_id) as subquery
GROUP BY area_id, avg_comp_from, avg_comp_to
order by area_id;	