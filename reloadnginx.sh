#!/bin/bash
echo '...begin...'
if [ $# -lt 1 ]; then
    echo $0 need a host parameter
    exit 0
fi
if [ ! -n "$2" ] ;then
   sleeptime=10
else
   sleeptime=$2
fi

echo '...refreshtime='${sleeptime}'s'
host=$1
ipfile="ip.ini"

while [ true ]; do

  runlogfile="run."`date "+%Y-%m-%d"`".log"
  reloadlogfile="reload."`date "+%Y-%m-%d"`".log"
  echo `date`'...read ip.ini...'>>"$runlogfile" >&1
  if [ ! -f "$ipfile" ]; then
    #touch "$ipfile"
    sh getip.sh "$host" > "$ipfile"
  fi

  oldIpAddress=`cat ip.ini |head -n 1`
  curIpAddress=`sh getip.sh "$host"`
  echo `date`'...oldIpAddress='${oldIpAddress} >>"$runlogfile"
  echo `date`'...curIpAddress='${curIpAddress} >>"$runlogfile"

  if [ "$oldIpAddress" != "$curIpAddress" ];then
     echo '..oldIpAddress:'${oldIpAddress}'!=curIpAddress:'${curIpAddress}'.......' >>"$runlogfile"
     /usr/local/tengine/sbin/nginx -s reload
     #修改为你自己nginx目录地址
     echo '...nginx -s reload....' >>"$runlogfile"
     sh getip.sh "$host" > "$ipfile"
     echo `date`'...ipchanged..oldIpAddress:'${oldIpAddress}'!=curIpAddress:'${curIpAddress}'...nginx -s reload!' >>"$reloadlogfile"
  fi
 
  /bin/sleep "$sleeptime"
done

echo '...end .....'
