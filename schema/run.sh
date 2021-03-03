#!/bin/sh
  
psql -h data.cs.jmu.edu bigdata < create.sql
./copy.sh &
psql -h data.cs.jmu.edu bigdata < stats.sql
psql -h data.cs.jmu.edu bigdata < alter.sql
psql -h data.cs.jmu.edu bigdata < index.sql
