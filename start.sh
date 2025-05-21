#!/bin/bash

ARGS=$@

# Reset all container named kali
docker kill kali
docker container rm kali

# Build new container
docker pull kalilinux/kali-rolling
docker build -t headless-kali .
docker run --name kali $ARGS -d -p 22:22 headless-kali

# Loop waits for container to start
echo "Waiting for container to start"
for i in {0..10}; do 
    echo -en "\r$i"
    #seq 1 1000000 | while read i; do echo -en "\r$i"; done
    sleep 1
done
echo ""

# Set new password
ssh -o "NoHostAuthenticationForLocalhost yes" -l root -L 5900:localhost:5900 localhost 'passwd'

# Start vnc server
ssh -o "NoHostAuthenticationForLocalhost yes" -l root -L 5900:localhost:5900 localhost 'x11vnc -localhost -display :1'
