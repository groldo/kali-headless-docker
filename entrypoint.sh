#!/bin/sh

# change root password

# this is a workaround
# obiuosly some permission are missing
ls -l $(which i3status)
cp $(which i3status) /root/i3status
cp /root/i3status $(which i3status)

service ssh start
Xvfb :1 -screen 0 800x600x16 -ac &
DISPLAY=:1 i3
