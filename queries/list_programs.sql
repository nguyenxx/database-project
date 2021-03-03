DROP FUNCTION IF EXISTS list_programs(catalog text);

CREATE FUNCTION list_programs(catalog text)
RETURNS TABLE(program text) AS $$

 	SELECT Distinct major
	FROM course
	WHERE major IS NOT NULL
		AND catalog_year = $1
	ORDER BY major ASC
  
$$ LANGUAGE SQL STABLE STRICT;

ALTER FUNCTION list_programs(catalog text) OWNER TO bigdata;
