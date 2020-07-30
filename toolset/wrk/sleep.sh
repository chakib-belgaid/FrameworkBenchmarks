#!/bin/bash
sleep 10
echo ""
echo "---------------------------------------------------------"
echo " sleeping during $duration for $name"
echo " Running Warmup $name"
echo "Sleep: $duration "
echo "---------------------------------------------------------"
echo ""
STARTTIME=$(date +"%s")
sleep $duration
echo "1 requests in " $duration
echo "STARTTIME $STARTTIME"
echo "ENDTIME $(date +"%s")"


