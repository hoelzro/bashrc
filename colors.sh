#!/bin/bash

use_color=false
safe_term=${TERM//[^[:alnum:]]/.}

if [[ -f /etc/DIR_COLORS ]] ; then
    grep -q "^TERM ${safe_term}" /etc/DIR_COLORS && use_color=true
elif type -p dircolors >/dev/null ; then
    if dircolors --print-database | grep -q "^TERM ${safe_term}" ; then
        use_color=true
    fi
fi

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
        PROMPT_COMMAND="$PROMPT_COMMAND ; __prompt"
        __prompt
    fi
else
    if [[ ${EUID} == 0 ]] ; then
        PS1='\u@\h \W \$ '
    else
        PS1='\u@\h \w \$ '
    fi
fi

