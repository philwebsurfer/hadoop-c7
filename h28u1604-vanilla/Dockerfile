FROM ubuntu:16.04
LABEL name="Ubuntu 16.04 - Hadoop 2.8 Vanilla" \
    vendor="philwebsurfer" \
    license="GPLv2" 

USER root

ENV DEBIAN_FRONTEND noninteractive

#Change mirrrors ad hoc, for speed
RUN sed -i 's!\(archive\|security\)\.ubuntu\.com/!mirror.cogentco.com/pub/linux/!g'\
 /etc/apt/sources.list

RUN apt-get update; \
 apt-get upgrade -y; \
 apt-get install -y --no-install-recommends apt-utils locales
RUN apt-get install -y --no-install-recommends bash-completion \
 openjdk-8-jre-headless screen openssh-server openssh-client rsync \
 vim openjdk-8-jdk-headless net-tools python telnet traceroute \
 iputils-ping dnsutils python3 curl wget less tzdata apt-file \
 bash-completion libssl-dev libsnappy-dev xzip
# Taken from https://github.com/docker-library/docs/tree/master/ubuntu
RUN rm -rf /var/lib/apt/lists/* && \
 localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 ; \
 rm -rf /etc/localtime; link /usr/share/zoneinfo/America/Mexico_City /etc/localtime
ENV LANG en_US.utf8
RUN systemctl enable ssh

#Do the Java things 
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

#Hadoop things
#https://www-us.apache.org/dist/hadoop/common/hadoop-2.8.3/hadoop-2.8.3.tar.gz
ADD hadoop-2.8.3.tar.gz /usr/local
RUN ln -sf /usr/local/hadoop-2.8.3 /usr/local/hadoop

#passwordless ssh (from
#https://store.docker.com/community/images/sequenceiq/hadoop-docker/dockerfile)
RUN rm -rf /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_rsa_key\
 /root/.ssh/id_rsa /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key; \
 ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key; \
 ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa; \
 cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys; \
 rm -rf /etc/update-motd.d/10-help-text
RUN echo StrictHostKeyChecking=no >> /etc/ssh/ssh_config; \
 echo export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 >> /root/.bashrc;\
 echo export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 >> /root/.profile;\
 echo export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 >> /usr/local/hadoop-2.8.3/etc/hadoop/hadoop-env.sh


#Environment vars setting
ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV PATH $PATH:$HADOOP_PREFIX/sbin:$HADOOP_PREFIX/bin

#Remove bat files for Windows: disrupt the autocomplete :-@
RUN find $HADOOP_PREFIX/ -iname '*.cmd' -exec rm -rf {} \;

#Volume mappings for cgroup
VOLUME [ "/sys/fs/cgroup" ]
VOLUME [ "/dfs" ]

#ssh
EXPOSE 22/tcp 
#sec name node
EXPOSE 50090/tcp 
#datanode dfsclient
EXPOSE 50010/tcp 
#datanode ipc
EXPOSE 50020/tcp
#MR job tracker
EXPOSE 50030
#namenode http
EXPOSE 50070/tcp
#datanode http
EXPOSE 50075/tcp
#yarn resman sched
EXPOSE 8030/tcp
#yarn resman tracker
EXPOSE 8031/tcp
#yarn resman
EXPOSE 8032/tcp
#yarn resman admin
EXPOSE 8033/tcp
#yarn resman webapp
EXPOSE 8088/tcp
#history server
EXPOSE 8188/tcp
CMD ["/bin/bash"]
#CMD ["/bin/bash"]
