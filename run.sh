#!/bin/bash
echo "will start tunnel at background"
nohub socat TCP4-LISTEN:5673,fork TCP4:localhost:5672 &>/dev/null
echo "background tunnel was started"