FROM ubuntu:16.04
LABEL name="Ubuntu 16.04 - Hadoop 27" \
    vendor="philwebsurfer" \
    license="GPLv2" 

USER root

### #Centos 7 recommends removing the following...
### RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
### systemd-tmpfiles-setup.service ] || rm -f $i; done); \
### rm -f /lib/systemd/system/multi-user.target.wants/*;\
### rm -f /etc/systemd/system/*.wants/*;\
### rm -f /lib/systemd/system/local-fs.target.wants/*; \
### rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
### rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
### rm -f /lib/systemd/system/basic.target.wants/*;\
### rm -f /lib/systemd/system/anaconda.target.wants/*;

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update; \
 apt-get upgrade -y; \
 apt-get install -y --no-install-recommends apt-utils locales
RUN apt-get install -y --no-install-recommends bash-completion \
 openjdk-8-jre-headless screen openssh-server openssh-client rsync
# Taken from https://github.com/docker-library/docs/tree/master/ubuntu
RUN rm -rf /var/lib/apt/lists/* && \
 localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
RUN systemctl enable ssh

#Do the Java things 
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre

#Hadoop things
#https://www-us.apache.org/dist/hadoop/common/hadoop-2.7.5/hadoop-2.7.5.tar.gz
ADD hadoop-2.7.5.tar.gz /usr/local
RUN ln -sf /usr/local/hadoop-2.7.5 /usr/local/hadoop

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
 echo export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre >> /root/.bashrc;\
 echo export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre >> /root/.profile


#Environment vars setting
ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV PATH $PATH:HADOOP_PREFIX/bin

#https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html
ADD hadoop-etc.tar.gz /usr/local/hadoop/

#Standalone config setting
## RUN mkdir $HADOOP_PREFIX/input
## RUN cp $HADOOP_PREFIX/etc/hadoop/*.xml $HADOOP_PREFIX/input
## 
## #Pseudo-distributed
## #haddop-etc.tar.gz created with this
## # tar cfz hadoop-etc.tar.gz hadoop-3.0.0/etc/hadoop/{core-site.xml,hdfs-site.xml}
## 
## #Volume mappings for cgroup
## VOLUME [ "/sys/fs/cgroup" ]
## 
EXPOSE 22
CMD ["/sbin/init"]
#CMD ["/bin/bash"]
