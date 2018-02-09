#!/bin/bash 
wget -c http://www-us.apache.org/dist/hadoop/common/hadoop-2.7.5/hadoop-2.7.5.tar.gz
echo 'docker build --rm=true -v /sys/fs/cgroup:/sys/fs/cgroup -t local/xenial-hadoop-base .'


