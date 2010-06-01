#!/usr/bin/env bash
cd $HOME/.myconfigs/ &&
    git reset --hard HEAD &&
    git pull &&
    $HOME/.myconfigs/scripts/create_links.bash
