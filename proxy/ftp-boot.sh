#!/bin/bash
#ls -alh /home/chrome/proxy/ftp-user
#/usr/local/bin/twistd -n ftp --password-file=/home/chrome/proxy/ftp-user -r /home/chrome/Downloads
python3 -m uploadserver  -d /home/chrome/Downloads 2121