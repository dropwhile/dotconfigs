# vim: set ft=sh:
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# detect os
export OS=$(uname -s)

#######################
#### function defs
#######################

###### os specific
case $OS in
    Darwin)
        # function to go to the directory of the topmost open
        # finder folder
        # from http://www.macosxhints.com/article.php?story=20060719155640762
        ff() {
            osascript -e 'tell application "Finder"'\
              -e "if (${1-1} <= (count Finder windows)) then"\
              -e "get POSIX path of (target of window ${1-1} as alias)"\
              -e 'else' -e 'get POSIX path of (desktop as alias)'\
              -e 'end if' -e 'end tell';
        };
        cdff() { cd "$(ff $@)"; };

        finder-update-window() {
            osascript -e 'tell application "Finder"'\
              -e 'tell front window'\
              -e 'update every item with necessity'\
              -e 'end tell' -e 'end tell';
        };

        finder-update-desktop() {
            osascript -e 'tell application "Finder"'\
              -e 'update desktop' -e 'end tell';
        };
        ;;
    Linux)
        ;;
esac

###### general
# fucntion to show git branch
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

dotfiles_update() {
    (cd ~/.myconfigs/ && git pull && ~/.myconfigs/scripts/create_links.bash)
}

get_whois_registrant() {
    while read domain; do
        echo "#### ${domain} ####"
        whois ${domain} | grep -A6 -E "(Registrant|Registration)"
    done
}

############################
#### environment settings
############################

###### os specific
case $OS in
    Darwin)
        export COPYFILE_DISABLE='true'
        if [ -x /opt/local/bin/port ]; then
            export PATH=/opt/local/bin:/opt/local/sbin:$PATH
            export MANPATH=/opt/local/share/man:$MANPATH

            ## lesspipe if installed ##
            LESSPIPEX="$(type -p lesspipe.sh)"
            [ -x "${LESSPIPEX}" ] && export LESSOPEN="|${LESSPIPEX} %s"

            ## bash_completion if installed ##
            [ -f /opt/local/etc/bash_completion ] &&
                . /opt/local/etc/bash_completion
        fi
        ;;
    Linux)
        if [ -e /etc/redhat-release ]; then
        # fix redhat goofy strip paths from PATH thing.
            PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
        fi

        ## dircolors stuff ##
        #[ -x /usr/bin/dircolors ] && eval "`dircolors -b`"
        export LS_COLORS='no=00:fi=00:di=34;40:ln=35;40:pi=33;40:so=36;40:bd=40;33;01:cd=40;33;01:or=35;40:mi=41;30;01:ex=31;40:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:';

        # make less more friendly for non-text input files, see lesspipe(1)
        type -p lesspipe 1>&- && eval "$(lesspipe)"

        ## enable bash completion ##
        [ -f /etc/bash_completion ] && . /etc/bash_completion
        ;;
esac

###### general
# If this is an xterm set the title to user@host:dir
case $TERM in
    xterm*)
        PROMPT_COMMAND='echo -ne "\033]0;@${HOSTNAME%%.*}\007"'
        ;;
    dumb)
        return
        ;;
    *) ;;
esac

# set ps1 to show git branch, using previously defined
# function. Also show different host color if over ssh.
# visual queue = winrar
# ( idea lifted from phrakture. pew pew! )
if [ -z "$SSH_TTY" ]; then
    PS1='\u@\h:\w$(parse_git_branch)\$ '
else
    PS1='\u\[\033[37m\]@\h\[\033[m\]:\w$(parse_git_branch)\$ '
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# send hup on exit
shopt -s huponexit

## some classic env vars ##
export EDITOR=vim
export VISUAL=vim
export PAGER=less

# erase dups before adding line, and ignore lines starting with spaces
# See bash(1) for more options
export HISTCONTROL="ignorespace:erasedups"
# suppress duplicate commands, the simple invocation of 'ls' without any
# arguments, and the shell built-ins bg, fg, and exit
# also ignores any command starting with a space
export HISTIGNORE="&:l[ls]:[bf]g:exit"
# disable saving of history -- only make history per/bash process
#unset HISTFILE

## enable colors in grep ##
export GREP_OPTIONS='--color=auto'

## some git specific vars ##
# vim on os x returns a non-zero exit code when called with the short
# path name. fucks up git & friends. Use full path.
export GIT_EDITOR=vim
export GIT_PAGER=less

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
export LESS="-Ri"

## set the gpg tty for helper apps (like gnupg.vim) ##
export GPG_TTY=$(tty)

# other environment vars
export MOZ_DISABLE_PANGO=1
export FIREFOX_DSP=none
export OOO_FORCE_DESKTOP=gnome
export CLICOLOR=1

## pull in gpg agent env var
if [ -n "$(type -p gpg-agent)" ] && [ -f "$HOME/.gpg-agent-info" ]; then
    . "$HOME/.gpg-agent-info"
    export GPG_AGENT_INFO
fi

# virtualenvwrapper stuff
VENVW="$(type -p virtualenvwrapper.sh)"
if [ -e "${VENVW}" ]; then
    source "${VENVW}"
    export WORKON_HOME=$HOME/.virtualenvs
    if [ -e "$(type -p pip)" ]; then
        export PIP_VIRTUALENV_BASE=$WORKON_HOME
        export PIP_REQUIRE_VIRTUALENV=true
        # prob don't need this. might be nice though.
        # eval `pip completion --bash`
    fi
fi

# add my own bin to the END of path
if [ -d ~/bin ] ; then
    export PATH="${PATH}:${HOME}/bin"
fi

##########################
#### aliases
##########################
## os specific
case $OS in
    Darwin)
        alias locate='mdfind -name'
        alias ls='ls -p'
        ;;
    Linux)
        alias ls='ls --color=auto -p'
        ;;
esac

### general
alias l.='ls -d .*'
alias ll='ls -lh'

alias date-custom='date +"%a %b %d %I:%M%P %Z %G"'
alias ps-custom='ps ax -o "pid user ni %cpu %mem tname stat time cmd"'
alias rtorrent='ulimit -n 512; ulimit -u 128; rtorrent'
