#!/bin/sh

## add c9admin
c9mkhomedir_helper.sh $C9USER $C9PASSWORD $C9UID $C9GROUP $C9GID $C9HOME $C9GRANT_SUDO
pm2 start $C9HOME/cloud9/server.js --name "$C9USER ($C9PORT)" --uid=$C9USER --cwd=$C9HOME -- \
  -w $C9HOME/workspace -p $C9PORT -l 0.0.0.0 -a $C9USER:$C9PASSWORD

## start pm2gui
sed -i "s~%PM2PORT%~$PM2PORT~g" /etc/pm2-gui.ini
sed -i "s~%PM2PASSWORD%~$PM2PASSWORD~g" /etc/pm2-gui.ini
pm2-gui start /etc/pm2-gui.ini
