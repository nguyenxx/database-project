-- ___________________________________________ 

DROP TABLE IF EXISTS enrollment;

CREATE TABLE enrollment (
        subject text,
        number integer,
        title text,
        enrolled integer,
        enrl_cap integer,
        term integer
);

ALTER TABLE enrollment OWNER TO bigdata;

COMMENT ON TABLE enrollment IS 'list of enrollment attributes';

-- ___________________________________________ 

DROP TABLE IF EXISTS course;

CREATE TABLE course (
        major text,
        catalog_year text,
        subject text,
        number integer,
        title text,
        description text,
        credits integer,
        prerequisite text,
        corequisite text,
        typically_offerd text,
        instruction_type text,
        is_gened text
);

COMMENT ON TABLE course IS 'list of course attributes';

ALTER TABLE course OWNER TO bigdata;

-- ___________________________________________ 

DROP TABLE IF EXISTS section;

CREATE TABLE section (
        subject text,
        number integer,
        section text,
        instructor text,
        days text,
        beg_time text,
        end_time text,
        room text
);
COMMENT ON TABLE section IS 'Each section of a course information';

ALTER TABLE section OWNER TO bigdata;

-- ___________________________________________ 
DROP TABLE IF EXISTS program;

CREATE TABLE program (
        catalog_year text,
        degree text,
        major text,
        program_description text
);

COMMENT ON TABLE course IS 'list of programs/majors';

ALTER TABLE program OWNER TO bigdata;
-- ___________________________________________ 
