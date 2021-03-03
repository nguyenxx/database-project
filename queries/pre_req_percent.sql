-- Creates a view of all majors and what percent of that majors classes
-- require a pre req to take a class

CREATE VIEW percent_pre AS
SELECT subject, CAST(100 / CAST(count(subject) AS DECIMAL(10,2)) 
	* count(prerequisite) AS int) 
FROM course
GROUP BY subject
ORDER BY subject;

ALTER VIEW percent_pre OWNER TO bigdata;
