#!/bin/bash

alias ack2="$HOME/bin/ack2 --noenv --ackrc=$HOME/.ack2rc"
alias cdblank="cdrecord --verbose dev=/dev/sr0 blank=fast"
alias cdburn="cdrecord --verbose --eject dev=/dev/sr0 driveropts=burnfree"
alias clyde='clyde --color'
alias cs='perl script/*_server.pl'
alias dvdblank="cdrecord --verbose dev=/dev/sr0 blank=fast"
alias dvdburn="cdrecord --verbose --eject dev=/dev/sr0"
alias grep="grep --colour=auto"
alias jbos=jobs
alias less="less -RM"
alias ls="ls $__LS_FLAGS"
alias myrip="rip -c -f \"%A - %S\" -O -n -T"
alias notify-rob="xmpp-notify.pl -c ~/.notifyrob.yaml"
alias perldoc="LANG=en_US perldoc"
alias xmltidy='tidy -xml -i 2>/dev/null'
