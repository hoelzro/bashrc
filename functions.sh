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
    builtin cd "$@" && run_dir_changed_hooks
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

