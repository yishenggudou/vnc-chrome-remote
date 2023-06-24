#!/bin/bash
#ls -alh /home/chrome/proxy/ftp-user
#/usr/local/bin/twistd -n ftp --password-file=/home/chrome/proxy/ftp-user -r /home/chrome/Downloads
/usr/local/bin/websockify --wrap-mode=respawn -v 0.0.0.0:5901  0.0.0.0:5900