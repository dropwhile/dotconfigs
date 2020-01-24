#!/bin/sh
cd $HOME/.myconfigs/ && git pull && $HOME/.myconfigs/scripts/setup.sh

if type zsh >/dev/null 2>&1; then
 $HOME/.myconfigs/scripts/recompile.zsh
fi

## cleanups
#rm -f ${HOME}/.profile.d
