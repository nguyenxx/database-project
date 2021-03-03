--CREATE INDEX ON enrollment(subject, number);
CREATE INDEX ON enrollment(title);
CREATE INDEX ON course(title, description);
CREATE INDEX ON course(credits);
CREATE INDEX ON section(section_size);
CREATE INDEX ON section(beg_time, end_time);
