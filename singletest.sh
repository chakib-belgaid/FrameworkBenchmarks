#! /bin/sh


setclients()
{
    server_host=$2
    client_host=$3
    database_host=$4
}

clients=`cat /root/client_addrs.txt `
setclients $clients


docker run \
    --rm \
  --network=host \
  --mount type=bind,source=/home/mbelgaid/FrameworkBenchmarks,target=/FrameworkBenchmarks \
  techempower/tfb \
  --server-host $server_host \
  --database-host $database_host \
  --client-host $client_host \
  --network-mode host \
  --network-mode host \
  --duration 20 \
  --mode verify \
  --test-dir $@