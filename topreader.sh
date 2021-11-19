#!/bin/bash

state="true"

while $state
do
    SMALL_REQUESTS=$(netstat -ant | awk -F'[ :]+' '/:22/{count[$4]++} END {for(ip in count) print count[ip]}' | sort -n | head -20 | head -1)
    if [ "$SMALL_REQUESTS" -gt 500 ];then
        sar -A > alert.txt
        state="false"
    else
        sleep 30
        continue
    fi
done    
