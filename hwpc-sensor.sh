#! /bin/bash
NAME=`cat /proc/sys/kernel/hostname`
DB='techempower'
COLLECTION="$NAME"_`date +"%Y-%m-%d"`
echo $DB $NAME $COLLECTION

docker run --net=host --privileged --name powerapi-sensor -d \
-v /sys:/sys -v /var/lib/docker/containers:/var/lib/docker/containers:ro \
-v /tmp/powerapi-sensor-reporting:/reporting \
powerapi/hwpc-sensor:latest \
-n "$NAME" \
-f 500 \
-r "mongodb" -U "mongodb://172.16.45.8:27017" -D "$DB" -C "$COLLECTION" \
-s "rapl" -o -e "RAPL_ENERGY_PKG" -e "RAPL_ENERGY_DRAM" \
-s "msr" -e "TSC" -e "APERF" -e "MPERF" \
-c "core" -e "CPU_CLK_THREAD_UNHALTED:REF_P" -e "CPU_CLK_THREAD_UNHALTED:THREAD_P" \
-e "LLC_MISSES" -e "INSTRUCTIONS_RETIRED"