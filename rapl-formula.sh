#!/bin/sh
INPUT_DB='techempower'
INPUT_COL="20200705075211"
OUTPUT_DB=$INPUT_DB
OUTPUT_COL=rapl_$INPUT_COL
docker run -it --rm --net=host --name powerapi-formula powerapi/rapl-formula \
           --input mongodb -u "mongodb://172.16.45.8:27017" -d $INPUT_DB -c $INPUT_COL \
           --output mongodb -u "mongodb://172.16.45.8:27017" -d $OUTPUT_DB -c $OUTPUT_COL