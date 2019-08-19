##########################
#### completion control
##########################
## completion stuff
zstyle ':compinstall' filename '$HOME/.zshrc'

comp_cmd='compinit'
if [[ -d $HOME/.tmpdots/ ]]; then
    zcachedir="$HOME/.tmpdots/.zcache"
    [[ -d "$zcachedir" ]] || mkdir -p "$zcachedir"

    zcompf="$zcachedir/zcompdump"
    # only re-eval compfile if at least one day has passed since last gen.
    if [[ -e "$zcompf" && $(date +'%j') != $(stat -f '%Sm' -t '%j' "$zcompf") ]]; then
        comp_cmd+=" -d $zcompf"
    else
        comp_cmd+=" -C -d $zcompf"
    fi
    unset zcompf

    zcompcdir="$zcachedir/zcompcache"
    [[ -d "$zcompcdir" ]] || mkdir -p "$zcompcdir"
    zstyle ':completion:*' cache-path "$zcompcdir"
    zstyle ':completion:*' use-cache on
    unset zcompcdir
    unset zcachedir
fi
eval "$comp_cmd"
unset comp_cmd

# Use menu completion
#zstyle ':completion:*' menu select
zstyle ':completion:*' menu 'select=4'

# simple matcher first, then case insensitive match
zstyle ':completion:*' matcher-list \
    '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Don't try parent path completion if the directories exist
zstyle ':completion:*' accept-exact-dirs true

# This way you tell zsh comp to take the first part of the path to be
# exact, and to avoid partial globs. Now path completions became nearly
# immediate.
zstyle ':completion:*' accept-exact '*(N)'

# Always use menu selection for `cd -`
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

# Verbose completion results
zstyle ':completion:*' verbose true

# Don't complete hosts from /etc/hosts
zstyle ':completion:*' hosts off

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

# Dont complete uninteresting stuff unless we really want to.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|TRAP*)'
zstyle ':completion:*:*:*:users' ignored-patterns '_*'

# Better SSH/Rsync/SCP Autocomplete
zstyle ':completion:*:(scp|rsync):*' tag-order ' hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
