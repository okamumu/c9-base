#!/bin/sh

mkdir -p $C9HOME
useradd -d $C9HOME -u $C9UID -g $C9GID -p `echo "$C9PASSWORD" | mkpasswd -s -m sha-512` $C9USER &&\
  echo "$C9USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$C9USER

## install c9

if [ ! -d $C9HOME/cloud9 ]; then
  su - $C9USER -c "git clone git://github.com/c9/core.git $C9HOME/cloud9"
  su - $C9USER -c "$C9HOME/cloud9/scripts/install-sdk.sh"
fi
su - $C9USER -c "mkdir -p $C9HOME/workspace"

su - $C9USER -c "$C9HOME/.c9/node/bin/node $C9HOME/cloud9/server.js -w $C9HOME/workspace -p $C9PORT -l 0.0.0.0 -a $C9USER:$C9PASSWORD --collab"
