#!/bin/bash
timestamp=`date -u`
oldconfig=$(cat /etc/postfix/main.cf | grep "relay_domains")
domains=$(curl -s https://DOMAIN.tld/api.php?key=123456) > /dev/null
newconfig="relay_domains = \$mydestination, $domains"

if [ "$oldconfig" != "$newconfig" ]; then
   echo $timestamp "Config change found"
   echo $timestamp "Old config: " $oldconfig
   echo $timestamp "New config: " $newconfig
   sed -i -e "s/$oldconfig/$newconfig/g" /etc/postfix/main.cf 
   service postfix reload
   echo $timestamp "Reloaded postfix"
else
   echo $timestamp "No config change found"
fi
