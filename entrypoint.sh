#!/bin/sh

## install c9

if [ ! -d $SUDOUSER_HOMEDIR/cloud9 ]; then
  git clone git://github.com/c9/core.git $SUDOUSER_HOMEDIR/cloud9
  $SUDOUSER_HOMEDIR/cloud9/scripts/install-sdk.sh
fi
mkdir -p $HOME/workspace

$SUDOUSER_HOMEDIR/.c9/node/bin/node $SUDOUSER_HOMEDIR/cloud9/server.js \
  -w $SUDOUSER_HOMEDIR/workspace \
  -p 8181 \
  -l 0.0.0.0 \
  -a $C9USER:$C9PASSWORD \
  --collab
