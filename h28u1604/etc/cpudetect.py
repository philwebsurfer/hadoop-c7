#!/usr/bin/env python3
#@author Jorge III Altamirano Astorga 2018
#@descr Returns proposed cpus for Hadoop to use
import re
import math

cpus = 0
cpuinfo = open('/proc/cpuinfo', 'r')

for line in cpuinfo:
    line = line.strip()
    if re.match("^processor\s+:\s+", line):
        line = re.sub("[^0-9]*", "", line)
        line = int(line)
        if line > cpus:
            cpus = int(line)
cpus += 1
cpuinfo.close()
# print("CPUs system-wide: %d"%cpus)

procinfo = open('/proc/self/cgroup', 'r')
for line in procinfo:
    line = line.strip()
    if re.match('.{1,5}:name=systemd:', line):
        dockerd = "/sys/fs/cgroup/cpu,cpuacct" + \
            re.sub("^.{1,5}:name=systemd:", "", line)

        if not re.match(".*/docker-", dockerd):
            continue
        print(dockerd)
        cpu_quota = open(dockerd + "/cpu.cfs_quota_us", 'r')
        for cpu_q in cpu_quota:
            cpu_q = cpu_q.strip()
            cpu_q = int(cpu_q)
            if cpu_q < 0:
                continue
            else:
                cpu_period = open(dockerd + "/cpu.cfs_period_us", 'r')
                for cpu_p in cpu_period:
                    cpu_p = cpu_p.strip()
                    cpu_p = int(cpu_p)
                cpu_period.close()
                cpus = cpu_q / cpu_p
            print("cpus %d"% cpus)
        cpu_quota.close()
procinfo.close()

cpus -= 1
if cpus < 1:
    cpus = 1
# print("Total cpus avail to the container: %d"%cpus)
print("%d"%(cpus))

