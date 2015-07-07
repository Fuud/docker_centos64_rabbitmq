#!/bin/bash
echo "will start tunnel at background"
nohup socat TCP4-LISTEN:5673,reuseaddr,fork TCP4:localhost:5672 &>/dev/null &
echo "background tunnel was started"