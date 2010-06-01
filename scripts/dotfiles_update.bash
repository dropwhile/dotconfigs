#!/usr/bin/env bash
cd $HOME/.myconfigs/ &&
    git pull &&
    $HOME/.myconfigs/scripts/create_links.bash
