FROM philwebsurfer/xenial-hadoop-vanilla:latest
LABEL name="Ubuntu 16.04 - Hadoop 2.8" \
    vendor="philwebsurfer" \
    license="GPLv2" 

USER root

ENV DEBIAN_FRONTEND noninteractive

#Hadoop things
ADD hadoop-etc.tar.gz /usr/local/hadoop-2.8.3/etc/
ADD etc.tar.gz /

#SSH things 
#RUN rm -rf /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_rsa_key\
# /root/.ssh/id_rsa /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
#RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key; \
# ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key; \
# ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa; \
# cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys; \
# rm -rf /etc/update-motd.d/10-help-text


#Volume mappings for cgroup
VOLUME [ "/sys/fs/cgroup" ]
VOLUME [ "/dfs" ]

EXPOSE 22/tcp 50090/tcp 50010/tcp 50020/tcp 50030 50070/tcp 50075/tcp 8030/tcp 8031/tcp 8032/tcp 8033/tcp 8088/tcp 8188/tcp
#ssh
#EXPOSE 22/tcp 
##sec name node
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
CMD ["/etc/bootstrap.sh", "singlenode"]
