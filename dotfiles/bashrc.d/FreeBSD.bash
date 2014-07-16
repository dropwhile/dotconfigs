export LSCOLORS='gxfxcxdxbxegedabagacad'
export BLOCKSIZE=K;
alias psf='ps wwfaux'
## enable bash completion, but only if it didn't get loaded by
## profile.d scripts or something
[[ $PS1 && -z "${BASH_COMPLETION}" && \
    -f /usr/local/share/bash-completion/bash_completion.sh ]] && \
    source /usr/local/share/bash-completion/bash_completion.sh
