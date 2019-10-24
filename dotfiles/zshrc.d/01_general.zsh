##########################
#### general options
##########################
# allow function calls in prompt
setopt prompt_subst

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

## autoloads
autoload -Uz edit-command-line

# enable Emacs style command editing
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

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
HISTSIZE=2100
SAVEHIST=2000


##########################
#### runtime help
##########################
unalias run-help
autoload run-help
alias help='run-help'
