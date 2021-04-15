#!/bin/bash

# Installation instructions from here:  https://www.youtube.com/watch?v=dQt8RaPSpq0

if (( $EUID != 0 )); then
   echo "Please run as root"
   exit
fi

# install necessary prerequites
#wait for the dpkg lock to be released
while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do
    sleep 1
done
while sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1 ; do
    sleep 1
done
if [ -f /var/log/unattended-upgrades/unattended-upgrades.log ]; then
    while sudo fuser /var/log/unattended-upgrades/unattended-upgrades.log >/dev/null 2>&1 ; do
        sleep 1
    done
fi
apt-get update 
apt-get -y install apache2 php

# copy files to apache html directory

cp -v -R backend fastsaas-singleServer-pretty.html *.js /var/www/html/

# use our page 
mv -v /var/www/html/fastsaas-singleServer-pretty.html /var/www/html/index.html
chown -v -R www-data /var/www/html/*

