#!/usr/bin/env python3
#@author Jorge III Altamirano Astorga 2018
#@descr Returns proposed memory in MB for use in Hadoop
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
cpuinfo.close()
print(cpus)

## procinfo = open('/proc/self/cgroup', 'r')
## for line in procinfo: 
##     line = line.strip()
##     if re.match('.{1,5}:name=systemd:', line):
##         dockerd = "/sys/fs/cgroup/memory" + \
##             re.sub("^.{1,5}:name=systemd:", "", line) + \
##             "/memory.stat"
##         if not re.match(".*/docker-", dockerd):
##             continue
##         #print(dockerd)
##         memstat = open(dockerd, 'r')
##         for memline in memstat:
##             memline = memline.strip()
##             #https://docs.docker.com/config/containers/runmetrics/#metrics-from-cgroups-memory-cpu-block-io
##             if re.match("hierarchical_memory_limit", memline):
##                 memline = re.sub("[^0-9]*", \
##                     "", memline)
##                 total = math.floor(int(memline) / 2**20)
##             #elif re.match("total_rss_huge", memline):
##             #    memline = re.sub("[^0-9]*", \
##             #        "", memline)
##             #    rss_huge = math.floor(int(memline) / 2**20)
##             elif re.match("total_rss", memline):
##                 memline = re.sub("[^0-9]*", \
##                     "", memline)
##                 rss = math.floor(int(memline) / 2**20)
##         free = (total - rss)
##         #print("Free: %d, RSS: %d, Total: %d"%(free, rss, total))
##         memstat.close()
## procinfo.close()
## #print("Total available memory to the container: %d kB"%total)
## 
## proposed = math.floor(free*0.8)
## if (proposed) < (free - 2048):
##     proposed = free - 2048
## if proposed < 1536:
##     proposed = 1536
## 
## #print("Proposed: %d"%(proposed))
## print("%d"%(proposed))
