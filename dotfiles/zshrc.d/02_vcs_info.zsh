##########################
#### git/vcs_info
##########################
## git/vcs_info prompt stuff
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
# disabled as it's slow
zstyle ':vcs_info:*' check-for-changes false
# this one is faster, but still a bit slow
zstyle ':vcs_info:*' check-for-staged-changes false
# use less complex info gathering mechanisms, when possible
zstyle ':vcs_info:*' use-simple true

#zstyle ':vcs_info:*' formats "(%b%F{yellow}%u%c%f)"
zstyle ':vcs_info:*' formats "%F{yellow}%u%c%f[%25>...>%b%>>]"
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '!'
#zstyle ':vcs_info:git:*' actionformats "(%b|%a%m%F{yellow}%u%c%f)"
zstyle ':vcs_info:git:*' actionformats "%a%m%F{yellow}%u%c%f[%25>...>%b%>>]"
zstyle ':vcs_info:git:*' patch-format ' %n/%a'

precmd() {
    vcs_info
}
