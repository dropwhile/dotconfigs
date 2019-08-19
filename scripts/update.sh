#!/bin/sh
cd $HOME/.myconfigs/ && git pull && $HOME/.myconfigs/scripts/setup.sh

type -p zsh &>/dev/null && $HOME/.myconfigs/scripts/recompile.zsh
