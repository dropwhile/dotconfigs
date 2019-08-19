#!/usr/bin/env zsh

setopt LOCAL_OPTIONS EXTENDED_GLOB NULL_GLOB

if [[ -d "$HOME/.zshrc.d/" ]]; then
    printf "recompiling .zshrc.zwc\n"
    autoload -U zrecompile

    # clean up old files
    rm -f $HOME/.zshrc.zwc $HOME/.zshrc.d/load.zsh.zwc
    find $HOME/.zshrc.d/ -type f -name "*.zwc" -delete

    # and make new ones!
    for file in $HOME/.zshrc.d/*_*.zsh; do
        zrecompile -pq $file
    done
    zrecompile -pq $HOME/.zshrc.d/load.zsh $HOME/.zshrc.d/*_*.zsh
    zrecompile -pq $HOME/.zshrc.zwc $HOME/.zshrc.d/*.zsh
fi
