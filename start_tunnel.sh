#!/bin/bash
echo "will start tunnel at background"
mkdir -p /var/log/socat
nohup socat -v TCP4-LISTEN:5673,reuseaddr,fork TCP4:localhost:5672 &>/var/log/socat/socat.log &
echo "background tunnel was started. Logs can be found at /var/log/socat/socat.log"