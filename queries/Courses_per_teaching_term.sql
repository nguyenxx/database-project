-- A funtion to find how many summer only courses each major has


DROP FUNCTION IF EXISTS teaching_type(type text);

CREATE FUNCTION teaching_type(t_type text)
RETURNS TABLE(major text, instruction_type text) AS $$

SELECT major, instruction_type
FROM course
WHERE typically_offerd = t_type


$$ LANGUAGE SQL STABLE STRICT;

ALTER FUNCTION teaching_type(type text) OWNER TO bigdata;






