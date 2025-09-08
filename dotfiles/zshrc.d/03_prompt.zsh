##########################
#### set prompt/PS1
##########################
#
# allow function calls in prompt
setopt no_prompt_bang prompt_percent prompt_subst

# check for ssh
hname=''
ps_c='%F{white}'
if [[ $IS_SSH -eq 1 ]]; then
    ps_c='%F{yellow}'

    if [[ -n "${TWO_DOT_HOSTNAME}" ]]; then
        hname='%2m'
    else
        hname='%m'
    fi
fi

## only show user if it isn't /my/ default user
upart=''
if [[ $USER != "elij" ]]; then
    upart='%n@'
fi

## only colon in prompt if there is something to the left of the curdir
ccolon=':'
if [[ $hname == '' && $upart == '' && $IS_SSH -ne 1 ]]; then
    ccolon=''
    ps_c=''
fi

# myprecmd() {
#     # Print a newline before the prompt, unless it's the
#     # first prompt in the process.
#     if [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
#         print ""
#     fi
#     if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
#         NEW_LINE_BEFORE_PROMPT=1
#     fi
# }
#
# autoload -Uz add-zsh-hook
# add-zsh-hook precmd myprecmd
# alias clear="unset NEW_LINE_BEFORE_PROMPT && clear"
# alias reset="unset NEW_LINE_BEFORE_PROMPT && reset"

#PS1=${ps_c}'%n@'${hname}'%f:%1~%(!.%F{red}.%f)${vcs_info_msg_0_}%#%f%E '
#PS1=${ps_c}'%n@'${hname}'%f:%1~%(!.%F{red}.%f)${vcs_info_msg_0_}%#%f '
#PS1=${ps_c}'%n@'${hname}'%f:%1~%(!.%F{red}.%f)%#%f '
#PS1=${ps_c}${upart}${hname}'%f'${ccolon}'%1~%(!.%F{red}.%f)%#%f '
#PS1=${ps_c}${upart}${hname}'%f'${ccolon}'%1~%(?..[%F{red}%?%f])%(!.%F{red}.%f)%#%f '
#PS1='╭─ '${ps_c}${upart}${hname}'%f'${ccolon}'%1~%(?..[%F{red}%?%f])%(!.%F{red}.%f) ${vcs_info_msg_0_}'$'\n''╰─ %#%f '
#PS1='┌─ '${ps_c}${upart}${hname}'%f'${ccolon}'%1~%(?.. [%F{red}%?%f])%(!.%F{red}.%f) ${vcs_info_msg_0_}'$'\n''└─ %#%f '
#RPS1='${vcs_info_msg_0_}'
PS1='┌─ '${ps_c}${upart}${hname}'%f'${ccolon}'%2~ ${vcs_info_msg_0_}'$'\n''%(?..[%F{red}%?%f] )%(!.%F{red}.%f)%#%f '
#PS1='%(?..[%F{red}%?%f] )%(!.%F{red}.%f)%#%f '
#RPS1='${vcs_info_msg_0_} '${ps_c}${upart}${hname}'%f'${ccolon}'%1~'
#RPS1=${ps_c}${upart}${hname}'%f'${ccolon}'%1~ ${vcs_info_msg_0_}'
unset ps_c hname upart ccolon TWO_DOT_HOSTNAME
