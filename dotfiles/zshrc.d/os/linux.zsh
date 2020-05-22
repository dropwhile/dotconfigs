## dircolors stuff ##
#[ -x /usr/bin/dircolors ] && eval "`dircolors -b`"
##export LS_COLORS='no=00:fi=00:di=36;40:ln=35;40:pi=33;40:so=36;40:bd=40;33;01:cd=40;33;01:or=35;40:mi=41;30;01:ex=31;40:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:'

#export LS_COLORS='no=00:fi=00:ca=00:di=36:ln=35:pi=33:so=36:bd=40;33;01:cd=40;33;01:or=35:mi=41;30;01:ex=31:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:'
export LS_COLORS='no=00:fi=00:ca=00:di=36:ln=35:pi=33:so=36:bd=40;33;01:cd=40;33;01:or=35:mi=41;30;00:ex=31:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:'

# make less more friendly for non-text input files, see lesspipe(1)
local lp="lesspipe"
LESSPIPEX=${lp:c}
[ -x $LESSPIPEX ] && eval "$(lesspipe)"

## if the above fails, try this too.
if [ $? -ne 0 ]; then
    ## lesspipe if installed ##
    local lp="lesspipe.sh"
    LESSPIPEX=${lp:c}
    [ -x "${LESSPIPEX}" ] && export LESSOPEN="|${LESSPIPEX} %s"
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
export SYSTEMD_PAGER=

unset GREP_OPTIONS
alias ls='ls -Np --color=auto --quoting-style=literal'
alias grep='grep --color=auto'
