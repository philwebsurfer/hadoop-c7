FROM ubuntu:16.04
LABEL name="Ubuntu 16.04 - Hadoop 2.8" \
    vendor="philwebsurfer" \
    license="GPLv2" 

USER root

ENV DEBIAN_FRONTEND noninteractive

#Hadoop things
ADD hadoop-etc.tar.gz /usr/local/hadoop-2.8.3/etc/hadoop

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
ENTRYPOINT ["/etc/bootstrap.sh", "singlenode"]
#CMD ["/bin/bash"]
