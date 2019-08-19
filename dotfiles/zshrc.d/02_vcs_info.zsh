##########################
#### git/vcs_info
##########################
## git/vcs_info prompt stuff
zstyle ':vcs_info:*' enable git svn
#zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' formats "(%b%u%c)"
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '!'
zstyle ':vcs_info:git:*' actionformats "(%b|%a%m%F{yellow}%u%c%f)"
zstyle ':vcs_info:git:*' patch-format ' %n/%a'

precmd() {
    vcs_info
}

