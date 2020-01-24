#!/bin/sh

if [ ! -d $HOME/.myconfigs ]; then
    echo "No ~/.myconfigs... Giving up!"
    exit 1
fi

# default to out of date
UP_TO_DATE=1

cd $HOME/.myconfigs/
git status -v|grep -q 'is up to date'
UP_TO_DATE=$?
[ $UP_TO_DATE -ne 0 ] && git pull

cd $HOME
$HOME/.myconfigs/scripts/setup.sh

if [ $UP_TO_DATE -ne 0 ] && type zsh >/dev/null 2>&1; then
    $HOME/.myconfigs/scripts/recompile.zsh
fi

## cleanups
#rm -f ${HOME}/.profile.d
