#!/usr/bin/env python3
#@author Jorge III Altamirano Astorga 2018
#@descr Returns proposed memory in MB for use in Hadoop
import re 
import math

meminfo = open('/proc/meminfo', 'r')
buffer = free = cache = None
lines = meminfo.readlines()
for line in lines:
    line = line.strip()
    if "MemFree:" in line:
        line = re.sub("[^0-9]*", "", line)
        free = int(line)
    elif "Buffers:" in line:
        line = re.sub("[^0-9]*", "", line)
        buffer = int(line)
    elif re.match("^Cached:", line):
        line = re.sub("[^0-9]*", "", line)
        cache = int(line)

total = (free + buffer + cache)/(2**10)
proposed = math.floor(total*0.8)
if(proposed < 1536):
    proposed = 1536
#print("Free: %d, Buffers: %d, Cache: %d, Total: %d"%(free, buffer, cache, total))
#print("Proposed: %d"%(proposed))
print("%d"%(proposed))
