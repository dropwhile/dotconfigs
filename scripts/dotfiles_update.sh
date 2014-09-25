#!/bin/sh
cd $HOME/.myconfigs/ &&
    git pull &&
    $HOME/.myconfigs/scripts/create_links.sh
