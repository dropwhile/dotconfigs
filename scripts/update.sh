#!/bin/sh
cd $HOME/.myconfigs/ && git pull && $HOME/.myconfigs/scripts/setup.sh

if type zsh 2>/dev/null; then
 $HOME/.myconfigs/scripts/recompile.zsh
fi
