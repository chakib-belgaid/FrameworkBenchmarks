#! /bin/sh


setclients()
{
    server_host=$2
    client_host=$3
    database_host=$3
}

clients=`cat /root/client_addrs.txt `
setclients $clients


measureit()
{
docker run \
    --rm \
  --network=host \
  --mount type=bind,source=/home/mbelgaid/FrameworkBenchmarks,target=/FrameworkBenchmarks \
  techempower/tfb \
  --server-host $server_host \
  --database-host $database_host \
  --client-host $client_host \
  --network-mode host \
  --duration 20 \
  --type all \
  --test-dir $@ 
}


# measureit $l

l=`cat names.txt | xargs -n 40` 

for i in `ls names` ; 
do 
  l=`cat names/$i`
  measureit $l
  echo $i >> done.txt
  sleep 10
done 