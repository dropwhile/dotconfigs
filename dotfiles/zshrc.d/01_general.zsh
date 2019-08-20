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
setopt hist_ignore_dups hist_ignore_space append_history share_history
setopt hist_find_no_dups hist_reduce_blanks hist_expire_dups_first
HISTORY_IGNORE="(l[lsa]|[bf]g|cd *|pushd *|popd *|exit|clear|reset)"
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=4000


##########################
#### runtime help
##########################
unalias run-help
autoload run-help
alias help='run-help'
