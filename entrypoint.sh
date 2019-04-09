#!/bin/sh

groupadd -f -g $C9GID $C9GROUP
useradd -d $C9HOME -u $C9UID -g $C9GID -p `echo "$C9PASSWORD" | mkpasswd -s -m sha-512` $C9USER
mkdir -p $C9HOME
chown $C9USER:$C9GROUP $C9HOME

if [ $GRANT_SUDO = "yes" ]; then
  echo "$C9USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$C9USER
fi

if [ ! -d $C9HOME/.bash_logout ]; then
  su - $C9USER -c "cp /etc/skel/.bash_logout $C9HOME/.bash_logout"
fi

if [ ! -d $C9HOME/.bashrc ]; then
  su - $C9USER -c "cp /etc/skel/.bashrc $C9HOME/.bashrc"
fi

if [ ! -d $C9HOME/.profile ]; then
  su - $C9USER -c "cp /etc/skel/.profile $C9HOME/.profile"
fi

## install c9

su - $C9USER -c "/usr/local/bin/c9-install.sh"

##

pm2 start $C9HOME/cloud9/server.js --no-daemon --uid=$C9USER --cwd=$C9HOME -- \
  -w $C9HOME/workspace -p $C9PORT -l 0.0.0.0 -a $C9USER:$C9PASSWORD
