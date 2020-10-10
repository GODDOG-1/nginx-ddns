#!/bin/sh
if [ $# -lt 1 ]; then
    echo $0 need a host parameter
    exit 0
fi
if [ ! -n "$2" ] ;then
   refreshtime=60
else
   refreshtime=$2
fi
host=$1
logfile="run."`date "+%Y-%m-%d"`".log"
nohup sh reloadnginx.sh "$host" "$refreshtime" >"$logfile" 2>&1 &
echo 'reload is run....refreshtime is '${refreshtime}'s...'
tail -f "$logfile"
#exec sh reloadnginx.sh "$host" > "$logfile" 2>&1
exit
