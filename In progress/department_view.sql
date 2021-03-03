--
--Department View
--Shows all classes by department, joined on composite primary keys (subject + number)
--note: must join section relation in order to remove duplicates from term
--
DROP VIEW department;
CREATE VIEW department AS
	SELECT e.subject, e.number, e.term, c.credits, 
	       c.description, c.prerequisite, c.title, 
		   c.typically_offerd
		FROM enrollment AS e, course AS c
			WHERE e.subject = c.subject
			AND CAST(c.number as CHAR(10)) = CAST(e.number as CHAR(10));

--Example: show all classes from a certain term
SELECT * FROM department 
WHERE term = 1168
ORDER BY subject, number ASC
LIMIT 1000;
