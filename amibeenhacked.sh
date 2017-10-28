#! /bin/bash

for ip in $(cat /var/log/audit/audit.log | grep "/usr/sbin/sshd" | grep "success" | awk '{print $16}' | grep addr | awk -F'=' '{print $2}' | sort -u )
  do  
    tentative=$(cat /var/log/audit/audit.log | grep $ip | grep failed | wc -l )
    country=$(whois $ip  | grep -m 1 country | cut -d ':' -f2 | tr -d '[[:space:]]' )
    belongto=$(whois $ip  | grep -m 1  descr  | cut -d ':' -f2); echo "$tentative $country  $ip $belongto"
  done  | sort -n -k1
