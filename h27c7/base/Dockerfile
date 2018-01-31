FROM centos:7
LABEL name="CentOS 7 - Hadoop" \
    vendor="philwebsurfer" \
    license="GPLv2" 

USER root

#Centos 7 recommends removing the following...
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

#Install packages needed
COPY rpm /root/rpm
RUN yum -y localinstall /root/rpm/*.rpm
##RUN yum install -y java-1.8.0-openjdk-headless.x86_64 ssh rsync\
## bash-completion screen openssh-server openssh-clients libselinux;
RUN systemctl enable sshd
RUN yum update -y;
RUN yum clean all; \
 rm -rf /var/cache/yum;

#Do the Java things 
ENV JAVA_HOME /usr/lib/jvm/jre

#Hadoop things
#https://www-us.apache.org/dist/hadoop/common/hadoop-3.0.0/hadoop-3.0.0.tar.gz
ADD hadoop-3.0.0.tar.gz /usr/local
RUN ln -sf /usr/local/hadoop-3.0.0 /usr/local/hadoop

#passwordless ssh (from
#https://store.docker.com/community/images/sequenceiq/hadoop-docker/dockerfile)
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

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

#Standalone config setting
RUN mkdir $HADOOP_PREFIX/input
RUN cp $HADOOP_PREFIX/etc/hadoop/*.xml $HADOOP_PREFIX/input

#Pseudo-distributed
#haddop-etc.tar.gz created with this
# tar cfz hadoop-etc.tar.gz hadoop-3.0.0/etc/hadoop/{core-site.xml,hdfs-site.xml}
ADD hadoop-etc.tar.gz /usr/local

#Volume mappings for cgroup
VOLUME [ "/sys/fs/cgroup" ]

EXPOSE 22

CMD ["/usr/sbin/init"]
