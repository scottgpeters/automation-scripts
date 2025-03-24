#!/bin/bash

MAC="xx:xx:xx:xx:xx:xx"
BROADCAST="xxx.xxx.xxx.xxx"
PORT=9

# Remove separators and convert MAC to binary
MAC_HEX=$(echo "$MAC" | sed 's/[:\-]//g')
MAGIC=$(printf '%.0s\xFF' {1..6})
for i in {1..16}; do
    MAGIC+=$(echo -n "$MAC_HEX" | sed 's/../\\x&/g')
done

# Send the packet via UDP
exec 3>/dev/udp/$BROADCAST/$PORT
echo -ne "$MAGIC" >&3
exec 3>&-
