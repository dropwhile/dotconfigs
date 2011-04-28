if [ -e /etc/redhat-release ]; then
    # fix redhat goofy strip paths from PATH thing.
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
fi

## dircolors stuff ##
#[ -x /usr/bin/dircolors ] && eval "`dircolors -b`"
export LS_COLORS='no=00:fi=00:di=36;40:ln=35;40:pi=33;40:so=36;40:bd=40;33;01:cd=40;33;01:or=35;40:mi=41;30;01:ex=31;40:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:'

# make less more friendly for non-text input files, see lesspipe(1)
type -p lesspipe &>/dev/null && eval "$(lesspipe)"

## if the above fails, try this too.
if [ $? -ne 0 ]; then
    ## lesspipe if installed ##
    LESSPIPEX="$(type -p lesspipe.sh)"
    [ -x "${LESSPIPEX}" ] && export LESSOPEN="|${LESSPIPEX} %s"
fi

## enable bash completion ##
[ -f /etc/bash_completion ] && . /etc/bash_completion

alias ls='ls -p --color=auto'
