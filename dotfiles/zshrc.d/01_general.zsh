##########################
#### general options
##########################
# enable interactive commnets
setopt interactive_comments

# extended/fancier zsh globbing
setopt extended_glob

# If a pattern for filename generation has no matches, print an error, instead
# of leaving it unchanged in the argument list.
setopt nomatch

# disable 'cd without cd' support
unsetopt auto_cd

# don't ask for confirmation for 'rm *'
setopt rm_star_silent
#setopt no_nomatch null_glob

## some bindkey fixes
bindkey -e
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "^[[3~" delete-char
bindkey \^U backward-kill-line

## autoloads
autoload -Uz edit-command-line

# enable Emacs style command editing
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

## https://www.arp242.net/zshrc.html
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search    # Arrow up
bindkey '^[[B' down-line-or-beginning-search  # Arrow down

# default is '*?_-.[]~=/&;!#$%^(){}<>'
# omit / so word splits on path component too
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'


##########################
#### history control
##########################
# Lines configured by zsh-newuser-install
setopt hist_ignore_all_dups hist_ignore_dups hist_expire_dups_first hist_find_no_dups
setopt hist_ignore_space hist_no_functions hist_no_store hist_reduce_blanks
# one or the other for inc_append_ or share_
# share_history is actual a little irritating sometimes, as a terminal window is like a
# "context", and having history polluted by default can make reruning things more
# challenging. default to inc_append_history and manually import history with `fc -RI`
# when desired.
#setopt share_history
#setopt append_history
setopt inc_append_history
HISTORY_IGNORE="(l[lsa]|[bf]g|cd *|pushd *|popd *|exit|clear|reset)"
HISTFILE=~/.zsh_history
HISTSIZE=2200
SAVEHIST=2000


##########################
#### runtime help
##########################
unalias run-help
autoload run-help
alias help='run-help'
# helpdir on macos is messed up
if [[ "$OS" == "darwin" ]]; then
  HELPDIR="/usr/share/zsh/${ZSH_VERSION}/help"
fi

##########################
#### path stuff
##########################
typeset -U PATH path

# add ~/bin if it exists, and isn't already in the path
# note: using the magic $path arrayish variable here
#[[ ${path[(ie)$HOME/bin]} -le ${#path} ]] ||
#    export PATH="${PATH}:${HOME}/bin"

_prepath() {
    for dir in "$@"; do
        [[ -L "$dir" ]] && dir=$dir:A
        [[ ! -d "$dir" ]] && return
        path=("$dir" $path[@])
    done
}
_postpath() {
    for dir in "$@"; do
        [[ -L "$dir" ]] && dir=$dir:A
        [[ ! -d "$dir" ]] && return
        path=($path[@] "$dir")
    done
}

_postpath "$HOME/bin"
