#!/bin/bash

use_color=true
safe_term=${TERM//[^[:alnum:]]/.}

function __prompt
{
    local user=$(whoami)
    local host=$(hostname)
    local time=$(date +%T)
    local wd=$(pwd)
    wd=${wd/$HOME/\~}

    local cyan="\[\033[36m\]"
    local green="\[\033[32m\]"
    local blue="\[\033[34m\]"
    local reset="\[\033[0m\]"
    local red="\[\033[31m\]"
    local bold="\[\033[;1m\]"

    local status_color

    PS1=''

    if git status &>/dev/null; then
        if git status -uno -s | grep -q . ; then
            status_color=$red
        else
            status_color=$green
        fi

        local branch=$(git branch --color=never | sed -ne 's/* //p')
        PS1="$PS1[$bold$status_color$branch$reset] "
    fi
    PS1="$PS1$cyan[$time] $green$user@$host $blue$wd \$ $reset"
}

if ${use_color} ; then
    if [[ ${EUID} == 0 ]] ; then
        PS1='\[\033[31m\]\h \[\033[34m\]\W \$ \[\033[00m\]'
    else
        if [[ -z "$PROMPT_COMMAND" ]]; then
            PROMPT_COMMAND=__prompt
        else
            PROMPT_COMMAND="$PROMPT_COMMAND ; __prompt"
        fi
        __prompt
    fi
else
    if [[ ${EUID} == 0 ]] ; then
        PS1='\u@\h \W \$ '
    else
        PS1='\u@\h \w \$ '
    fi
fi

