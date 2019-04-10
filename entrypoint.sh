#!/bin/sh

## add c9admin
c9mkhomedir_helper.sh $C9USER $C9PASSWORD $C9UID $C9GROUP $C9GID $C9HOME $C9GRANT_SUDO
c9start.sh $C9USER $C9PASSWORD $C9HOME $C9PORT

## start pm2gui
sed -i "s~%PM2PORT%~$PM2PORT~g" /etc/pm2-gui.ini
sed -i "s~%PM2PASSWORD%~$PM2PASSWORD~g" /etc/pm2-gui.ini
pm2-gui start /etc/pm2-gui.ini
