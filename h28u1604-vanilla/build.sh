#!/bin/bash 
#@desc: Building script
wget -c http://mirror.cogentco.com/pub/apache/hadoop/common/hadoop-2.8.3/hadoop-2.8.3.tar.gz
wget -c http://mirror.cogentco.com/pub/apache/hive/hive-2.3.2/apache-hive-2.3.2-bin.tar.gz
wget -c http://mirror.cogentco.com/pub/apache/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz
wget -c http://mirror.cogentco.com/pub/apache/pig/pig-0.17.0/pig-0.17.0.tar.gz 
wget -c http://mirror.cogentco.com/pub/apache/accumulo/1.8.1/accumulo-1.8.1-bin.tar.gz
wget -c http://mirror.cogentco.com/pub/apache/hbase/stable/hbase-1.2.6-bin.tar.gz
wget -c http://mirror.cogentco.com/pub/apache/zookeeper/zookeeper-3.4.11/zookeeper-3.4.11.tar.gz
wget -c https://codeload.github.com/cloudera/hue/tar.gz/cdh5.13.2-release
#wget -c http://www-us.apache.org/dist/hadoop/common/hadoop-2.8.3/hadoop-2.8.3.tar.gz

echo 'Executing this to build:'
echo 'docker build --rm=true --force-rm -v /sys/fs/cgroup:/sys/fs/cgroup:ro -t docker.io/philwebsurfer/xenial-hadoop-vanilla:2.8.3 .'
docker build --rm=true --force-rm -v /sys/fs/cgroup:/sys/fs/cgroup:ro -t docker.io/philwebsurfer/xenial-hadoop-vanilla .

echo 'To run'
echo 'docker run --rm --memory=16G --cpu-period="100000"  --cpu-quota="400000" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v ~/dfs_n1:/dfs --hostname ja175904 --rm -it philwebsurfer/xenial-hadoop-vanilla'
echo 'docker run --rm --memory=16G --cpu-period="100000"  --cpu-quota="400000" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v ~/dfs_n1:/dfs --hostname av175875 --rm -it philwebsurfer/xenial-hadoop-vanilla'
echo 'docker run --rm --memory=16G --cpu-period="100000"  --cpu-quota="400000" -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v ~/dfs_n1:/dfs --hostname em175921 --rm -it philwebsurfer/xenial-hadoop-vanilla'

