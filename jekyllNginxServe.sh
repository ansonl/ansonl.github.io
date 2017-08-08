#!/bin/sh
sudo rm -rf /var/www/html/*
sudo jekyll build --destination /var/www/html/ --watch
