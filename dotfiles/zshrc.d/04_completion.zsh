##########################
#### completion control
##########################
## completion stuff
zstyle ':compinstall' filename '$HOME/.zshrc'

if [[ -d $HOME/.tmpdots/ ]]; then
    compinit -d $HOME/.tmpdots/.zcompdump
else
    compinit
fi

# Use menu completion
#zstyle ':completion:*' menu select
zstyle ':completion:*' menu 'select=4'

# simple matcher first, then case insensitive match
zstyle ':completion:*' matcher-list \
    '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Don't try parent path completion if the directories exist
zstyle ':completion:*' accept-exact-dirs true

# Always use menu selection for `cd -`
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

# Verbose completion results
zstyle ':completion:*' verbose true

# Don't complete hosts from /etc/hosts
zstyle -e ':completion:*' hosts 'reply=()'

# Use ls-colors for path completions
function _set-list-colors() {
     local LS_COLORS='no=00:fi=00:ca=00:di=36:ln=35:pi=33:so=36:bd=40;33;01:cd=40;33;01:or=35:mi=41;30;01:ex=31:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:'
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
	unfunction _set-list-colors
}
_set-list-colors

# list dirs first
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' single-ignored show

# Don't complete uninteresting stuff unless we really want to.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|TRAP*)'
zstyle ':completion:*:*:*:users' ignored-patterns '_*'
