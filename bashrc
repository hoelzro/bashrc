if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now
	return
fi

if [[ $(uname) == 'Darwin' ]]; then # if we're on OS X
    __LS_FLAGS='-G'
else
    __LS_FLAGS='--color=auto'
fi

if which brew &>/dev/null; then # if Homebrew is installed
    __BREW_ROOT=$(brew --prefix)
fi

# Shell options
shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist
shopt -s extglob
shopt -s histappend

if [[ ${BASH_VERSINFO[0]} -ge 4 ]]; then
    shopt -s autocd
    shopt -s dirspell
fi

# Perlbrew
if [[ -e ~/.perlbrew/etc/bashrc ]]; then
    source ~/.perlbrew/etc/bashrc
fi

# Programmable completion
if [[ -e /etc/bash_completion ]]; then
    source /etc/bash_completion
elif [[ ! -z "$__BREW_ROOT" ]] && [[ -e "$__BREW_ROOT/etc/bash_completion" ]]; then
    source $__BREW_ROOT/etc/bash_completion
fi

# Autojump
if [[ -e /etc/profile.d/autojump.bash ]]; then
    source /etc/profile.d/autojump.bash
elif [[ ! -z "$__BREW_ROOT" ]] && [[ -e "$__BREW_ROOT/etc/autojump.bash" ]]; then
    source $__BREW_ROOT/etc/autojump.bash
fi

source ~/.bashrc_scripts/colors.sh
source ~/.bashrc_scripts/functions.sh
source ~/.bashrc_scripts/aliases.sh
source ~/.bashrc_scripts/env.sh

# Site-specific customizations
if [[ -e ~/.bashrc_scripts/local.sh ]]; then
    source ~/.bashrc_scripts/local.sh
fi

# Bash::Completion plugins
if which setup-bash-complete &>/dev/null ; then
    . setup-bash-complete
fi

set -o noclobber

ls_limited
