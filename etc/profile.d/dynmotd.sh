#!/bin/sh

sessions() {
  userlist="$(users | sed 's/\s\+/\n/g')"
  uniqusers="$(echo "$userlist" | uniq)"
  uniqcount="$(echo "$uniqusers" | wc -l)"
  for i in $(seq 1 $uniqcount); do
    uniquser="$(echo "$uniqusers" | sed "${i}q;d")"
    sessions="$(echo "$userlist" | grep "$uniquser" | wc -l)"
    echo -n "$uniquser"
    [[ 1 < $sessions ]] && echo -n " (${sessions})"
    [[ $i < $uniqcount ]] && echo -n ", "
  done
  echo
}

lastlog() {
  if [[ -f ~/.lastlog.dynmotd ]]; then
    date -d "$(cat ~/.lastlog.dynmotd)" '+%A, %d %B %Y %R %Z'
  else
    echo "never"
  fi
  date >~/.lastlog.dynmotd
}

diskinfo() { df / -h | sed -n 2p; }

dependenciesDir=../../usr/local/lib/dynmotd

cat ${dependenciesDir}/header.txt

echo -e "
    MOTD:\t\t $(cat ${dependenciesDir}/motd.txt)

    Date and time:\t $(date '+%A, %d %B %Y %R %Z')
    Uptime:\t\t $(uptime -p)
    Kernel info:\t $(uname -smr)
    Disk space used:\t $(diskinfo | awk '{print $5}')  $(diskinfo | awk '{print $3}') / $(diskinfo | awk '{print $2}')  ($(diskinfo | awk '{print $4}') free)

    Hostname:\t\t $(hostname)
    Sessions:\t\t $(sessions)
    Last login:\t\t $(lastlog)
"
