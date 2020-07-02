#!/bin/bash




PKG0='/sys/devices/virtual/powercap/intel-rapl/intel-rapl:0/energy_uj'
MAXPKG0=`cat /sys/devices/virtual/powercap/intel-rapl/intel-rapl:0/max_energy_range_uj`
DRAM0='/sys/devices/virtual/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:0/energy_uj'
PKG1='/sys/devices/virtual/powercap/intel-rapl/intel-rapl:1/energy_uj'
MAXPKG1=`cat /sys/devices/virtual/powercap/intel-rapl/intel-rapl:1/max_energy_range_uj`
DRAM1='/sys/devices/virtual/powercap/intel-rapl/intel-rapl:1/intel-rapl:1:0/energy_uj'

while getopts "v" o; do
    case "${o}" in
        v) 
            verbose="True"
        ;;   
        esac
done
shift $((OPTIND-1))


beginT=` date +"%s%N"`
beginPKG0=` cat $PKG0`
beginDRAM0=` cat $DRAM0`
beginPKG1=` cat $PKG1`
beginDRAM1=` cat $DRAM1`


echo 'pkg   energy (mJ):'       $beginPKG0,$beginPKG1 
echo 'dram  energy (mJ):'       $beginDRAM0, $beginDRAM1

if [[ -n $verbose ]] 
then 
/usr/bin/time -apv $@
else
$@
fi

endT=` date +"%s%N"`
endPKG0=` cat $PKG0`
endDRAM0=` cat $DRAM0`
endPKG1=` cat $PKG1`
endDRAM1=` cat $DRAM1`

duration=$((($endT - $beginT)/1000000))

pkg0=$((($endPKG0-$beginPKG0)/1000))
pkg1=$((($endPKG1-$beginPKG1)/1000))

if [[ $pkg0 -le 0 ]]
then 
    pkg0=$(($pkg0 + $MAXPKG0))
fi 

if [[ $pkg1 -le 0 ]]
then 
    pkg1=$(($pkg1 + $MAXPKG1))
fi 

dram0=$((($endDRAM0-$beginDRAM0)/1000))
dram1=$((($endDRAM1-$beginDRAM1)/1000))

pkg=$(($pkg0+$pkg1))
dram=$(($dram0+$dram1))

# echo 'duration (ms)'   $duration
if [[ -z $verbose ]] 
then
    echo 'duration (ms):'   $duration  >&2
fi 

echo 'pkg   energy (mJ):'       $pkg0, $pkg1  'total: ' $pkg  >&2
echo 'dram  energy (mJ):'       $dram0, $dram1 'total: ' $draml >&2