#!/bin/bash

export BROWSER="chromium"
export DBIC_TRACE_PROFILE=console
export DEVEL_REPL_PROFILE=Rob
export EDITOR=vim
export EMAIL='rob@hoelz.ro'
export GIT_AUTHOR_NAME='Rob Hoelz'
export GIT_AUTHOR_EMAIL='rob@hoelz.ro'
export GIT_COMMITTER_NAME='Rob Hoelz'
export GIT_COMMITTER_EMAIL='rob@hoelz.ro'
export HISTFILESIZE=25000
export HISTIGNORE="exit"
export HISTSIZE=1000
export LUA_HISTORY=~/.luahist
export LUA_HISTSIZE=100
export LUA_INIT="@$HOME/.luarc"
export MANPAGER=man-pager
export MANPATH=$MANPATH:/usr/share/man
export MPD_HOST=127.0.0.1
export MYSQL_PS1="mysql [\U \d]:\c> "
export PAGER="less -RM"
export PATH=$PATH:~/bin/
export PERLDOC_PAGER=man-pager
export PERL_CPANM_OPT="--mirror file:///~/minicpan --mirror http://mirror.sit.wisc.edu/pub/CPAN/ --mirror http://cpan.cpantesters.org/"
export PGUSER=postgres
export WINEARCH=win32
PROMPT_COMMAND='history -a'
