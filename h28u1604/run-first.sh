#!/bin/bash 
tar cfz hadoop-etc.tar.gz hadoop
tar cfz etc.tar.gz etc

echo 'Executing this to build:'
echo 'docker build --rm=true --force-rm -v /sys/fs/cgroup:/sys/fs/cgroup:ro -t docker.io/philwebsurfer/xenial-hadoop-base:2.8.3 .'
docker build --rm=true --force-rm -v /sys/fs/cgroup:/sys/fs/cgroup:ro -t docker.io/philwebsurfer/xenial-hadoop-base:2.8.3 .

echo 'to run as host network'
echo 'docker run --rm -p 8088:8088 --memory=16g --cpu-period="100000"  --cpu-quota="400000" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v ~/dfs_n1:/dfs --hostname ja175904 --network host --rm -it philwebsurfer/xenial-hadoop-base:2.8.3'
echo 'docker run --rm -p 2222:22   --memory=16g --cpu-period="100000"  --cpu-quota="400000" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v ~/dfs_n1:/dfs --hostname av175875 --network host --rm -it philwebsurfer/xenial-hadoop-base:2.8.3'
echo 'docker run --rm -p 2222:22   --memory=16g --cpu-period="100000"  --cpu-quota="400000" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v ~/dfs_n1:/dfs --hostname em175921 --network host --rm -it philwebsurfer/xenial-hadoop-base:2.8.3'
echo
echo 'to run using docker networking'
echo 'docker run --rm -p 8088:8088 --memory=16g --cpu-period="100000"  --cpu-quota="400000" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v ~/dfs_n1:/dfs --hostname ja175904  --rm -it philwebsurfer/xenial-hadoop-base:2.8.3'
echo 'docker run --rm -p 2222:22   --memory=16g --cpu-period="100000"  --cpu-quota="400000" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v ~/dfs_n1:/dfs --hostname av175875  --rm -it philwebsurfer/xenial-hadoop-base:2.8.3'
echo 'docker run --rm -p 2222:22   --memory=16g --cpu-period="100000"  --cpu-quota="400000" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v ~/dfs_n1:/dfs --hostname em175921  --rm -it philwebsurfer/xenial-hadoop-base:2.8.3'

