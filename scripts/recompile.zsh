#!/usr/bin/env zsh

setopt LOCAL_OPTIONS EXTENDED_GLOB NULL_GLOB

if [[ -d "$HOME/.zshrc.d/" ]]; then
    printf "recompiling .zshrc.zwc\n"
    autoload -U zrecompile

    rm -f $HOME/.zshrc.zwc

    find $HOME/.zshrc.d/ -type f -name "*.zwc" -delete
    for file in $HOME/.zshrc.d/*.zsh; do
        zrecompile -pq $file
    done
fi
