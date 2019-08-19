##########################
#### exports
##########################
# some classic env vars
export EDITOR=vim
export VISUAL=vim
export PAGER=less

## some git specific vars ##
export GIT_EDITOR=vim
# pager is set it .gitconfig core.pager
# setting it here overrides that setting (and subsequent args)
#export GIT_PAGER=less

# vim on os x returns a non-zero exit code when called with the short
# path name. fucks up git & friends. Use full path.
if [[ "$OS" == "Darwin" ]]; then
    export GIT_EDITOR=/usr/bin/vim
    export EDITOR=/usr/bin/vim
    export VISUAL=/usr/bin/vim
fi

## less specific vars ##
# turn off .lesshst file
export LESSHISTFILE="-"
# color highlighting in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS="Ri"

# other environment vars
#export MOZ_DISABLE_PANGO=1
#export FIREFOX_DSP=none
#export OOO_FORCE_DESKTOP=gnome
export CLICOLOR=1

# pip/virtualenvstuff
export PIP_LOG_FILE=/dev/null
export PIP_DISABLE_PIP_VERSION_CHECK=1

# nix stuff
export NIX_PAGER=cat


#######################
#### special function defs
#######################


dotfiles_update() {
    $HOME/.myconfigs/scripts/update.sh
}


##########################
#### aliases
##########################
## special case for getting color on linux.
## why can't it use an env var like bsd ls?? *sigh*
alias l.='ls -d .*'
alias ll='ls -lh'
alias myip="curl icanhazip.com"
