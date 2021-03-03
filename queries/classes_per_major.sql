  
DROP FUNCTION IF EXISTS classes_per_major(major text);

CREATE FUNCTION classes_per_major(major text)
RETURNS TABLE(major text, number_of_courses bigint) AS $$

  SELECT major, COUNT(Distinct(number)) AS number_of_courses
  FROM course
  WHERE major = $1
  GROUP BY major
  
$$ LANGUAGE SQL STABLE STRICT;

ALTER FUNCTION classes_per_major(major text) OWNER TO bigdata;
