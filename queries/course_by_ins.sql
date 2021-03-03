-- group courses in the Chemistry major by class instruction type

DROP FUNCTION IF EXISTS course_by_ins(major text);

CREATE FUNCTION course_by_ins(major text)
RETURNS TABLE(instruction_type text, count_courses bigint) AS $$

  SELECT instruction_type, count(title) as count_courses
  FROM course
  WHERE major = $1
  GROUP BY major, instruction_type
  ORDER BY count_courses

$$ LANGUAGE SQL STABLE STRICT;

ALTER FUNCTION course_by_ins(major text) OWNER TO bigdata;
