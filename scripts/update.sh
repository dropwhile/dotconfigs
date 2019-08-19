#!/bin/sh
cd $HOME/.myconfigs/ && git pull && $HOME/.myconfigs/scripts/setup.sh

if type -p zsh &>/dev/null; then
 $HOME/.myconfigs/scripts/recompile.zsh
fi
