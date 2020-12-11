#!/bin/bash

# Installation instructions from here:  https://www.youtube.com/watch?v=dQt8RaPSpq0

if (( $EUID != 0 )); then
   echo "Please run as root"
   exit
fi

# install necessary prerequites
apt update 
apt -y install apache2 php

# copy files to apache html directory

cp -v -R backend fastsaas-singleServer-pretty.html *.js /var/www/html/

# use our page 
mv -v /var/www/html/fastsaas-singleServer-pretty.html /var/www/html/index.html
chown -v -R www-data /var/www/html/*

