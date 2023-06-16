#!/bin/bash
#/usr/bin/python3 /home/chrome/proxy/pyproxy.py --tcp -v -d 127.0.0.1:9222 -s 0.0.0.0:9223
/usr/sbin/nginx -g 'daemon off;' -c /home/chrome/proxy/nginx.conf