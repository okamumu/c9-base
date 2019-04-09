#!/bin/sh

if [ ! -d $HOME/cloud9 ]; then
  git clone git://github.com/c9/core.git $HOME/cloud9
  $HOME/cloud9/scripts/install-sdk.sh
fi
mkdir -p $HOME/workspace
