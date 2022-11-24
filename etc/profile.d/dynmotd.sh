#!/bin/sh

lastlog () {
  if [[ -f ~/.lastlog.dynmotd ]]; then
    date -d "$(cat ~/.lastlog.dynmotd)" '+%A, %d %B %Y %R %Z'
  else
    echo "never"
  fi
  date > ~/.lastlog.dynmotd
}

dependenciesDir=../../usr/local/lib/dynmotd

cat ${dependenciesDir}/header.txt

echo
echo -e "    MOTD:\t\t" `cat ${dependenciesDir}/motd.txt`
echo
echo -e "    Date and time:\t" `echo $(date '+%A, %d %B %Y %R %Z')`
echo -e "    Uptime:\t\t" `uptime -p`
echo -e "    Kernel info:\t" `uname -smr`
echo -e "    Disk space used:\t" `df -h | grep sda3 | awk '{print $5}'`"   "`df -h | grep sda3 | awk '{print $3}'` / `df -h | grep sda3 | awk '{print $2}'` " ("`df -h | grep sda3 | awk '{print $4}'` "своб.)"
echo
echo -e "    Hostname:\t\t" `hostname`
echo -e "    Sessions:\t\t" `${dependenciesDir}/sessions.sh`
echo -e "    Last login:\t\t $(lastlog)"