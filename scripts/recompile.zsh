#!/usr/bin/env zsh

setopt LOCAL_OPTIONS EXTENDED_GLOB

if [[ -d "$HOME/.zshrc.d/" ]]; then
    printf "recompiling .zshrc.d zsh scripts\n"
    find $HOME/.zshrc.d/ -type f -name "*.zwc" -delete
    autoload -U zrecompile
    for f in $HOME/.zshrc.d/**/*.zsh; do
        zrecompile -pq $HOME/.zshrc.d/load.zsh $HOME/.zshrc.d/*_*.zsh
    done
fi
