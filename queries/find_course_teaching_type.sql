-- A funtion to find how many classes are tought in a specific term


DROP FUNCTION IF EXISTS teaching_type(type text);

CREATE FUNCTION teaching_type(t_type text)
RETURNS TABLE(major text, instruction_type text) AS $$

SELECT major, instruction_type
FROM course
WHERE typically_offerd = t_type


$$ LANGUAGE SQL STABLE STRICT;






