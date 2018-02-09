#!/bin/bash 
wget -c http://www-us.apache.org/dist/hadoop/common/hadoop-2.7.4/hadoop-2.7.4.tar.gz

echo 'Execute this to build:'
echo 'docker build --rm=true -v /sys/fs/cgroup:/sys/fs/cgroup -t local/xenial-hadoop-base .'

echo 'To run'
echo 'docker run --rm -p 2222:22  -v /sys/fs/cgroup:/sys/fs/cgroup --rm -it local/xenial-hadoop-base'

