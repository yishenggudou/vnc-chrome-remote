#!/bin/bash
#/usr/bin/python3 /home/chrome/proxy/pyproxy.py --tcp -v -d 127.0.0.1:9222 -s 0.0.0.0:9223
if [ -z "${EXPOSE_PORT}" ]; then
  D_EXPOSE_PORT='9222'
else
  D_EXPOSE_PORT=${EXPOSE_PORT}
fi
echo D_EXPOSE_PORT:${D_EXPOSE_PORT}
sed "s/D_EXPOSE_PORT/${D_EXPOSE_PORT}/" /home/chrome/proxy/nginx.conf.default >/home/chrome/proxy/nginx.conf
/usr/sbin/nginx -g 'daemon off;' -c /home/chrome/proxy/nginx.conf
