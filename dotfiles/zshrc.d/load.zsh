### Load os specific settings
[ -s "$HOME/.zshrc.d/os/$OS.zsh" ] && source "$HOME/.zshrc.d/os/$OS.zsh"

# disable START/STOP output control
if [ -x /bin/stty ]; then
    /bin/stty -ixon
    /bin/stty -ixoff
fi

for file in $HOME/.zshrc.d/[0-9][0-9]_*.zsh; do
    source $file
done
