export LSCOLORS='gxfxcxdxbxegedabagacad'
export BLOCKSIZE=K;

## enable bash completion, but only if it didn't get loaded by
## profile.d scripts or something
[ -n "$PS1" ] && [ -n "$BASH" ] && [ -z "${BASH_COMPLETION}" ] && \
    [ -f /usr/local/share/bash-completion/bash_completion.sh  ] && \
    source /usr/local/share/bash-completion/bash_completion.sh

alias psf='ps wwfaux'
alias ls='ls -p'
