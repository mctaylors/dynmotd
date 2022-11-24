#!/bin/sh


# !!! WARNING !!!
# THIS SCRIPT IS INTENDED ONLY FOR THE OPERATION OF DYNMOTD
# You can get the regular version here:
# https://gist.github.com/mctaylors/53cd2524aec5564c9566bc0c5bc2d76d


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