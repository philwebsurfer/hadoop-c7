FROM ubuntu:16.04
LABEL name="Ubuntu 16.04 - Hadoop 2.8 Vanilla" \
    vendor="philwebsurfer" \
    license="GPLv2" 

USER root

ENV DEBIAN_FRONTEND noninteractive

#Change mirrrors ad hoc, for speed
RUN sed -i 's!\(archive\|security\)\.ubuntu\.com/!mirror.cogentco.com/pub/linux/!g'\
 /etc/apt/sources.list; \
 apt-get update; \
 apt-get upgrade -y; \
 apt-get install -y --no-install-recommends apt-utils locales; \
 apt-get install -y --no-install-recommends bash-completion \
 openjdk-8-jre-headless screen openssh-server openssh-client rsync \
 vim openjdk-8-jdk-headless net-tools python telnet traceroute \
 iputils-ping dnsutils python3 curl wget less tzdata apt-file \
 bash-completion libssl-dev libsnappy-dev xzip
# Taken from https://github.com/docker-library/docs/tree/master/ubuntu
RUN rm -rf /var/lib/apt/lists/* && \
 localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8; \
 rm -rf /etc/localtime; link /usr/share/zoneinfo/America/Mexico_City /etc/localtime; \
 systemctl enable ssh
ENV LANG=en_US.utf8 JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

#Hadoop things
#https://www-us.apache.org/dist/hadoop/common/
ADD hadoop-2.8.3.tar.gz \
 apache-hive-2.3.2-bin.tar.gz \
 pig-0.17.0.tar.gz \
 sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz \
 accumulo-1.8.1-bin.tar.gz \
 zookeeper-3.4.11.tar.gz \
 hbase-1.2.6-bin.tar.gz \ 
 /usr/local/
### accumulo native
COPY libaccumulo.so /usr/local/accumulo-1.8.1/lib/native/libaccumulo.so
RUN ln -sf /usr/local/hadoop-2.8.3 /usr/local/hadoop; \
 ln -sf /usr/local/apache-hive-2.3.2-bin /usr/local/hive; \
 ln -sf /usr/local/pig-0.17.0 /usr/local/pig; \
 ln -sf /usr/local/sqoop-1.4.7.bin__hadoop-2.6.0 /usr/local/sqoop; \
##########################
 ln -sf /usr/local/accumulo-1.8.1 /usr/local/accumulo; \
 ln -sf /usr/local/zookeeper-3.4.11 /usr/local/zookeeper; \
 ln -sf /usr/local/hbase-1.2.6 /usr/local/hbase

#passwordless ssh (from
#https://store.docker.com/community/images/sequenceiq/hadoop-docker/dockerfile)
RUN rm -rf /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_rsa_key \
 /root/.ssh/id_rsa /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys; \
 ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key; \
 ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key; \
 ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa; \
 cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys; \
 rm -rf /etc/update-motd.d/10-help-text; \
 echo StrictHostKeyChecking=no >> /etc/ssh/ssh_config; \
 echo export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 >> /root/.bashrc;\
 echo export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 >> /root/.profile;\
 echo export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 >> /usr/local/hadoop-2.8.3/etc/hadoop/hadoop-env.sh

#Environment vars setting
ENV HADOOP_PREFIX=/usr/local/hadoop \
 HADOOP_COMMON_HOME=/usr/local/hadoop \
 HADOOP_HDFS_HOME=/usr/local/hadoop \
 HADOOP_MAPRED_HOME=/usr/local/hadoop \
 HADOOP_YARN_HOME=/usr/local/hadoop \
 HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop \
 HIVE_HOME=/usr/local/hive \
 PIG_HOME=/usr/local/pig \
 SQOOP_HOME=/usr/local/sqoop \
 ACCUMULO_HOME=/usr/local/accumulo \
 ZOOKEEPER_HOME=/usr/local/zookeeper \
 HBASE_HOME=/usr/local/hbase 
ENV YARN_CONF_DIR=$HADOOP_PREFIX/etc/hadoop \
 HCAT_HOME=$HIVE_HOME/hcatalog \
 PATH=$PATH:$HADOOP_PREFIX/sbin:$HADOOP_PREFIX/bin:\
$PATH:$PIG_HOME/sbin:$PIG_HOME/bin:\
$PATH:$HIVE_HOME/sbin:$HIVE_HOME/bin:\
$PATH:$HCAT_HOME/sbin:$HCAT_HOME/bin:\
$PATH:$SQOOP_HOME/sbin:$SQOOP_HOME/bin:\
$PATH:$ACCUMULO_HOME/sbin:$ACCUMULO_HOME/bin:\
$PATH:$ZOOKEEPER_HOME/sbin:$ZOOKEEPER_HOME/bin:\
$PATH:$HBASE_HOME/sbin:$HBASE_HOME/bin 

#Remove bat files for Windows: disrupt the autocomplete :-@
RUN find $HADOOP_PREFIX/ $PIG_HOME/  \
 $SQOOP_HOME/ $ZOOKEEPER_HOME/ \
 -iname '*.cmd' -exec rm -rf {} \;

#Volume mappings for cgroup
VOLUME [ "/sys/fs/cgroup" ]
VOLUME [ "/dfs" ]

#ssh
EXPOSE 22/tcp  50090/tcp 50010/tcp 50020/tcp 50030 50070/tcp 50075/tcp 8030/tcp 8031/tcp 8032/tcp 8033/tcp 8088/tcp 8188/tcp
#sec name node
#EXPOSE 50090/tcp 
##datanode dfsclient
#EXPOSE 50010/tcp 
##datanode ipc
#EXPOSE 50020/tcp
##MR job tracker
#EXPOSE 50030
##namenode http
#EXPOSE 50070/tcp
##datanode http
#EXPOSE 50075/tcp
##yarn resman sched
#EXPOSE 8030/tcp
##yarn resman tracker
#EXPOSE 8031/tcp
##yarn resman
#EXPOSE 8032/tcp
##yarn resman admin
#EXPOSE 8033/tcp
##yarn resman webapp
#EXPOSE 8088/tcp
##history server
#EXPOSE 8188/tcp
CMD ["/bin/bash"]
#CMD ["/bin/bash"]
