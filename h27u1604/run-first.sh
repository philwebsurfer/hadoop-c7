#!/bin/bash 
wget -c http://mirror.cogentco.com/pub/apache/hadoop/common/hadoop-2.7.4/hadoop-2.7.4.tar.gz
#wget -c http://www-us.apache.org/dist/hadoop/common/hadoop-2.7.4/hadoop-2.7.4.tar.gz

echo 'Execute this to build:'
echo 'docker build --rm=true -v /sys/fs/cgroup:/sys/fs/cgroup:ro -t local/xenial-hadoop-base .'

echo 'To run'
echo 'docker run --rm -p 2222:22  -v /sys/fs/cgroup:/sys/fs/cgroup:ro --hostname ja_006766 --network host --rm -it local/xenial-hadoop-base'
echo 'docker run --rm -p 2222:22  -v /sys/fs/cgroup:/sys/fs/cgroup:ro --hostname av_175875 --network host --rm -it local/xenial-hadoop-base'
echo 'docker run --rm -p 2222:22  -v /sys/fs/cgroup:/sys/fs/cgroup:ro --hostname em_175921 --network host --rm -it local/xenial-hadoop-base'

