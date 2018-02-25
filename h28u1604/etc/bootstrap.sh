#!/bin/bash
service ssh start
cat /etc/hosts.cluster >> /etc/hosts
if [ -f '/dfs/data/current/VERSION' ]
then
        echo HDFS is formatted, skipping formatting
else 
        echo HDFS is formatted, formatting...
        $HADOOP_PREFIX/bin/hdfs namenode -format
fi
CPU=$(/etc/cpudetect.py)
CPUHALF=$(/etc/cpudetecthalf.py)
MEMORY=$(/etc/memdetect.py)
sed -i "s/MEMORY/$MEMORY/" /usr/local/hadoop/etc/hadoop/yarn-site.xml.cluster
sed -i "s/MEMORY/$MEMORY/" /usr/local/hadoop/etc/hadoop/yarn-site.xml.singlenode
sed -i "s/CPU/$CPU/" /usr/local/hadoop/etc/hadoop/yarn-site.xml.cluster
sed -i "s/CPU/$CPU/" /usr/local/hadoop/etc/hadoop/yarn-site.xml.singlenode
sed -i "s/CPU/$CPUHALF/" /usr/local/hadoop/etc/hadoop/yarn-site.xml.cluster
sed -i "s/CPU/$CPUHALF/" /usr/local/hadoop/etc/hadoop/yarn-site.xml.singlenode
cp -a /usr/local/hadoop/etc/hadoop/core-site.xml.cluster /usr/local/hadoop/etc/hadoop/core-site.xml
cp -a /usr/local/hadoop/etc/hadoop/yarn-site.xml.cluster /usr/local/hadoop/etc/hadoop/yarn-site.xml
cp -a /usr/local/hadoop-2.8.3/etc/hadoop/slaves.cluster  /usr/local/hadoop-2.8.3/etc/hadoop/slaves
cp -a /usr/local/hadoop-2.8.3/etc/hadoop/mapred-site.xml.cluster /usr/local/hadoop-2.8.3/etc/hadoop/mapred-site.xml
cp -a /usr/local/hadoop-2.8.3/etc/hadoop/hdfs-site.xml.cluster /usr/local/hadoop-2.8.3/etc/hadoop/hdfs-site.xml
$HADOOP_PREFIX/sbin/start-dfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh
$HADOOP_PREFIX/mr-jobhistory-daemon.sh start historyserver
/bin/bash
