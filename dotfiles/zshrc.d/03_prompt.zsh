##########################
#### set prompt/PS1
##########################
# check for ssh
hname=''
ps_c='%F{white}'
if [[ $IS_SSH -eq 1 ]]; then
    IS_SSH=1
    ps_c='%F{yellow}'

    if [[ -n "${TWO_DOT_HOSTNAME}" ]]; then
        hname='%2m'
    else
        hname='%m'
    fi
fi

#PS1=${ps_c}'%n@'${hname}'%f:%1~%(!.%F{red}.%f)${vcs_info_msg_0_}%#%f%E '
#PS1=${ps_c}'%n@'${hname}'%f:%1~%(!.%F{red}.%f)${vcs_info_msg_0_}%#%f '
PS1=${ps_c}'%n@'${hname}'%f:%1~%(!.%F{red}.%f)%#%f '
RPS1='${vcs_info_msg_0_}'
unset ps_c hname TWO_DOT_HOSTNAME
