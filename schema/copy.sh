#!/bin/sh

export PGHOST=data.cs.jmu.edu

echo COPY enrollment FROM jmudb
psql -c "COPY (
    SELECT subject, number, title, enrolled, enrl_cap, term
    FROM enrollment
    ) TO STDOUT ;" jmudb | \
    psql -c "COPY enrollment (subject, number, title, enrolled, enrl_cap, term) FROM STDIN;" bigdata

echo COPY course FROM jmudb
psql -c 'Copy (
    SELECT "Course Type", "Catalog Name", "Prefix", substr("Code", 1, 3)::integer, "Name", "Description (Rendered no HTML)", substr("Credits", 1, 1)::integer,
    "Prerequisite: (Rendered no HTML)", "Corequisite: (Rendered no HTML)", "Typically Offered:", "Course Component 1", "Course Attribute 2"
    FROM ugcatalog
    )  TO STDOUT;' jmudb | \
    psql -c "COPY course (major, catalog_year, subject, number, title, description, credits, prerequisite, corequisite, typically_offerd, instruction_type, is_gened) FROM STDIN;" bigdata

echo COPY course FROM jmudb
psql -c 'Copy (
    SELECT "Course Type", "Catalog Name", "Prefix", substr("Code", 1, 3)::integer, "Name", "Description (Rendered no HTML)", substr("Credits", 1, 1)::integer,
    "Prerequisite: (Rendered no HTML)", "Corequisite: (Rendered no HTML)", "Course Typically Offered", "Graded Component", "Course Attribute 2"
    FROM ugcourse
    )  TO STDOUT;' jmudb | \
    psql -c "COPY course (major, catalog_year, subject, number, title, description, credits, prerequisite, corequisite, typically_offerd, instruction_type, is_gened) FROM STDIN;" bigdata

echo COPY section FROM jmudb
psql -c "COPY (
    SELECT subject, number, section, instructor, days, beg_time, end_time, room
    FROM enrollment
    ) TO STDOUT;" jmudb | \
    psql -c "COPY section (subject, number, section, instructor, days, beg_time, end_time, room) FROM STDIN;" bigdata

echo COPY program FROM jmudb
psql -c 'COPY (
    SELECT "Catalog Name", "Degree Type", "Program Name", "Program Description"
    FROM ugprogram
    ) TO STDOUT;' jmudb | \
    psql -c "COPY program (catalog_year, degree, major, program_description) FROM STDIN;" bigdata
