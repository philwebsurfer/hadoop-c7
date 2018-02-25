#!/bin/bash 
wget -c http://mirror.cogentco.com/pub/apache/hadoop/common/hadoop-2.8.3/hadoop-2.8.3.tar.gz
#wget -c http://www-us.apache.org/dist/hadoop/common/hadoop-2.8.3/hadoop-2.8.3.tar.gz

echo 'Executing this to build:'
echo 'docker build --rm=true --force-rm -v /sys/fs/cgroup:/sys/fs/cgroup:ro -t docker.io/philwebsurfer/xenial-hadoop-vanilla .'
docker build --rm=true --force-rm -v /sys/fs/cgroup:/sys/fs/cgroup:ro -t docker.io/philwebsurfer/xenial-hadoop-vanilla .

echo 'To run'
echo 'docker run --rm --memory=16G --cpu-period="100000"  --cpu-quota="400000" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v ~/dfs_n1:/dfs --hostname ja175904 --rm -it philwebsurfer/xenial-hadoop-vanilla'
echo 'docker run --rm --memory=16G --cpu-period="100000"  --cpu-quota="400000" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v ~/dfs_n1:/dfs --hostname av175875 --rm -it philwebsurfer/xenial-hadoop-vanilla'
echo 'docker run --rm --memory=16G --cpu-period="100000"  --cpu-quota="400000" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v ~/dfs_n1:/dfs --hostname em175921 --rm -it philwebsurfer/xenial-hadoop-vanilla'

