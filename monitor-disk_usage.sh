#!/bin/sh
for server in more /home/ridho/servers-dpk.txt
do
output=ssh $server df -kh | grep -vE '^Filesystem' | awk '{ print $5 " " $1 }' 
hostname=ssh $server hostname
#echo $output
#echo $hostname
  used=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
  if [ $used -ge 20 ]; then
    echo "The partition \"$partition\" on \"$hostname\" has used $used% at $(date)" | mail -s "Disk space alert: $used% used" mridhohafidz12@gmail.com
  fi
done
