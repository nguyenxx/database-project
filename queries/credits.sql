--What is the average credit amount of each class in a major?
--Schema: Subject, avg credits
--Order: Subject

DROP VIEW IF EXISTS department;
CREATE VIEW department AS
	SELECT e.subject, e.number, e.term, c.credits, 
	       c.description, c.prerequisite, c.title, 
		   c.typically_offerd
		FROM enrollment AS e, course AS c
			WHERE e.subject = c.subject
			AND CAST(c.number as CHAR(10)) = CAST(e.number as CHAR(10));
ALTER VIEW department OWNER TO bigdata;

--add to seperate file perhaps
--SELECT subject,
--    AVG(CAST((CAST(credits as CHAR(1))) as int))
--	FROM department 
--	GROUP BY subject
--ORDER BY avg ASC
--LIMIT 1000;
