#!/usr/bin/env zsh

setopt LOCAL_OPTIONS EXTENDED_GLOB

if [[ -d "$HOME/.zshrc.d/" ]]; then
    printf "recompiling .zshrc.zwc\n"
    find $HOME/.zshrc.d/ -type f -name "*.zwc" -delete
    rm -f $HOME/.zshrc.zwc
    autoload -U zrecompile
    zrecompile -pq $HOME/.zshrc $HOME/.zshrc.d/*_*.zsh
fi
