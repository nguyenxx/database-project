# STEPS TO CREATE DATABASE

1. Run create.sql to create the table columns.
   Linux command: psql -h data.cs.jmu.edu bigdata < create.sql
   
2. Run copy.sh to copy data from the "jmudb" database.
   Linux command: ./copy.sh

3. Run alter.sql to add the PRIMARY/FOREIGN key constraints.
   Linux command: psql -h data.cs.jmu.edu bigdata < alter.sql

4. Run stats.sql to analyze tables and count the rows.
   Linux command: psql -h data.cs.jmu.edu bigdata < stats.sql

5. Run index.sql to create indexes to speed up queriess.
   Linux command: psql -h data.cs.jmu.edu bigdata < index.sql
