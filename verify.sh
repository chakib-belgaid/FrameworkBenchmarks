#! /bin/bash 

l=`cat names/xaf`

sum=0
for i in ${l[@]}; 
do 
    for j in `ls frameworks/$i/*.dockerfile` ; 
    do 
        sum=$((sum+1))
    done
done 
echo $sum