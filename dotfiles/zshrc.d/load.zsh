### Load os specific settings
[ -s "$HOME/.zshrc.d/os/$OS.zsh" ] && . "$HOME/.zshrc.d/os/$OS.zsh"

# disable START/STOP output control
if [ -x /bin/stty ]; then
    /bin/stty -ixon
    /bin/stty -ixoff
fi

for file in $HOME/.zshrc.d/*_*.zsh; do
    source $file
done
