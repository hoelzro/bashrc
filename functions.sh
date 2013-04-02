#!/bin/bash

LS_LIMIT=400
function ls_limited()
{
    file_count=`ls | wc -l`
    if test $file_count -gt $LS_LIMIT
    then
	echo "Over $LS_LIMIT files were found; listing the first $LS_LIMIT"
	ls $__LS_FLAGS | head -$LS_LIMIT
    else
	ls $__LS_FLAGS
    fi
}

declare -a __dir_changed_hooks

function run_dir_changed_hooks
{
    for hook_name in "${__dir_changed_hooks[@]}"; do
        $hook_name "$@"
    done
}

function add_dir_changed_hook
{
    local index="${#__dir_changed_hooks[*]}"
    __dir_changed_hooks[$index]="$1"
}

add_dir_changed_hook ls_limited

cd() {
    if [[ $1 == '-' ]]; then
        local length=${#__directory_ring[*]}
        if [[ $length -gt 0 ]] ; then
            local last_directory=${__directory_ring[$(( $length - 1 ))]}
            unset __directory_ring[$(( $length - 1 ))]

            builtin cd "$last_directory"
            run_dir_changed_hooks
        else
            echo "Directory ring is empty."
        fi
    elif [[ $1 =~ ^hoelzro: && ! -d $1 ]]; then
        cd ${1/hoelzro:/}
    elif [[ $1 =~ github:.*/ && ! -d $1 ]]; then
        cd ${1/github:*\//}
    else
        if builtin cd "$@" ; then
            local length

            length=${#__directory_ring[*]}
            __directory_ring[$length]="$OLDPWD"
            length=$(( $length + 1 ))

            if [[ $length -gt 5 ]]; then
                for i in $(seq 0 $(( $length - 2 )) ) ; do
                    __directory_ring[$i]="${__directory_ring[$(( $i + 1 ))]}"
                done
                unset __directory_ring[$(( $length - 1 ))]
            fi

            run_dir_changed_hooks
        fi
    fi
}

pushd() {
    builtin pushd "$@" && run_dir_changed_hooks
}

popd() {
    builtin popd "$@" && run_dir_changed_hooks
}

function knock {
    for port in $2 $3 $4; do
        nc $1 $port
        sleep 1
    done
}

function ov {
    sudo openvpn "/etc/openvpn/$1.conf"
}

# I often type this by mistake instead of !p
function 1p {
    eval $(history -p '!p')
}

function e {
    env | grep -i $1 | sort
}

function man {
    local size
    local columns
    local old_options

    old_options=$BASHOPTS
    shopt -s extglob
    size=$(stty size </dev/tty)
    columns=${size##+([0-9])}
    export MANWIDTH=$(( $columns - 5 ))
    command man "$@"

    if [[ ! $old_options =~ 'extglob' ]]; then
        shopt -s extglob
    fi
}
