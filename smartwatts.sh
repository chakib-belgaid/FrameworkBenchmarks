#!/bin/sh
INPUT_DB='techempower'
INPUT_COL="20200705075211"
OUTPUT_DB=$INPUT_DB
OUTPUT_COL=powers_$INPUT_COL
CPU_TDP=85
BASE_CPU_RATIO=22
MIN_CPU_RATIO=12
MAX_CPU_RATIO=31
docker run -t -rm --net=host   --name powerapi-formula powerapi/smartwatts-formula \
--input mongodb --model HWPCReport \
-u "mongodb://172.16.45.8:27017" -d $INPUT_DB -c $INPUT_COL \
--output mongodb --name power --model PowerReport \
-u "mongodb://172.16.45.8:27017" -d $OUTPUT_DB -c $OUTPUT_COL \
--output mongodb --name formula --model FormulaReport \
-u "mongodb://172.16.45.8:27017" -d $OUTPUT_DB -c frep \
--formula smartwatts --cpu-ratio-base $BASE_CPU_RATIO \
--cpu-ratio-min $MIN_CPU_RATIO \
--cpu-ratio-max $MAX_CPU_RATIO \
--sensor-reports-frequency 500 \
--cpu-tdp $CPU_TDP \
--cpu-error-threshold 2.0 \
--dram-error-threshold 2.0 \
--disable-dram-formula