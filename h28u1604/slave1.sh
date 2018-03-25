#!/bin/bash
master=$(docker ps -a --format '{{.ID}}' -f label=slave1)
docker stop $master 2>/dev/null || \
 docker kill $master 2>/dev/null
docker rm $master 2>/dev/null
docker run -d \
  -l slave1 \
  -n slave1 \
  --memory=20g \
  --cpu-period="100000"  --cpu-quota="400000" \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
  -v ~jaa6766/dfs_n2:/dfs \
  --hostname slave1 -it \
  philwebsurfer/xenial-hadoop-base:2.8.3
#  -p 8088:8088 #hadoop web
#  -p 1022:22 \ #ssh
#  -p 19888:19888 \ #jobhistoryserver
#  -p 8033 \ #resman
#  -p 50070 \ # Hadoop Admin
#  -p 50075 \ #datanode
#  -p 50090 \ #hdfs
