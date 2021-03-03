--What is the student/teacher ratio by department?
DROP VIEW department;
CREATE VIEW department AS
	SELECT DISTINCT e.subject, c.number
		FROM enrollment AS e
			INNER JOIN course AS c ON c.subject = e.subject
			AND CAST(c.number as CHAR(10)) = CAST(e.number as CHAR(10));

SELECT * FROM department
ORDER BY subject, number ASC
LIMIT 1000;
