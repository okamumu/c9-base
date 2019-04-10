#!/bin/sh

C9USER=$1
C9PASSWORD=$2
C9HOME=$3
C9PORT=$4

pm2 start $C9HOME/cloud9/server.js --name "$C9USER ($C9PORT)" --uid=$C9USER --cwd=$C9HOME -- \
  -w $C9HOME/workspace -p $C9PORT -l 0.0.0.0 -a $C9USER:$C9PASSWORD
