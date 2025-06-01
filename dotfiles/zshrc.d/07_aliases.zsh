##########################
#### aliases
##########################
alias ls.='ls -d .*'
alias ll.='ls -ld .*'
alias la='ls -a'
alias ll='ls -lh'
alias vimp='vim -p'
alias mvimp='mvim -p'

alias gs="git st"
alias gd="git diff"
alias ga="git add"
alias gp="git push"
alias gu="git pull"
alias gl="git log"
alias gb="git branch"

# aliases to import history when desired
alias import-history='fc -RI'
alias history-import=import-history

# misc stuff
alias myip="curl icanhazip.com"
alias td='date +%Y-%m-%d'

##########################
#### dir hashes
##########################
hash -d p=$HOME/projects
