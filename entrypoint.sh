#!/bin/sh

groupadd -f -g $C9GID $C9GROUP
useradd -d $C9HOME -u $C9UID -g $C9GID -p `echo "$C9PASSWORD" | mkpasswd -s -m sha-512` $C9USER &&\
  echo "$C9USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$C9USER
mkdir -p $C9HOME
chown -R $C9USER:$C9GROUP $C9HOME

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

if [ ! -d $C9HOME/cloud9 ]; then
  su - $C9USER -c "git clone git://github.com/c9/core.git $C9HOME/cloud9"
  su - $C9USER -c "$C9HOME/cloud9/scripts/install-sdk.sh"
fi
su - $C9USER -c "mkdir -p $C9HOME/workspace"

su - $C9USER -c "PATH=$PATH $C9HOME/.c9/node/bin/node $C9HOME/cloud9/server.js -w $C9HOME/workspace -p $C9PORT -l 0.0.0.0 -a $C9USER:$C9PASSWORD --collab"
