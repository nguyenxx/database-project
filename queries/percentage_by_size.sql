DROP FUNCTION IF EXISTS percentage_by_size(size int);

CREATE FUNCTION percentage_by_size(size int)
RETURNS TABLE(class_size int, percentage_of_classes_under_25_people float) AS $$

  SELECT $1,
	(Select Cast(Count(Distinct(title)) AS float) 
	 FROM enrollment 
	 WHERE enrl_cap < $1) 
		/ Cast(Count(Distinct(title)) AS float) * 100 As percentage_of_classes_under_25_people
  FROM enrollment
  
$$ LANGUAGE SQL STABLE STRICT;

ALTER FUNCTION percentage_by_size(size int) OWNER TO bigdata;
