################
#description  : This script will be executed by bash 
#bash_version : 5.1.4(1)-release
#author	     : krishnam
################

tracing_enabled=1

########
# system level run commands
########
defaultsdir=/usr/local/lib/initfiles
if [ -r $defaultsdir/system-bashrc ]; then . $defaultsdir/system-bashrc; fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

######## 
# History 
########

# don't put duplicate lines or lines starting with space in the history [ubuntu21.04 default]
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it  [ubuntu21.04 default]
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# cranked up default by 10x
HISTSIZE=10000
HISTFILESIZE=20000

# colorful promt
PS1='\[\033[01;32m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h\[\033[01;3$((1 + $RANDOM % 7))m\]$ \[\033[0m\]'

######## 
# Alias definitions 
########
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# source command is a bash built-in, if you want to be compatable with posix, use "." here.
# source, at present support only one file at a time, Let's iterate over our alias dir to load all. 
# I have named all bash compatable alias files with .bash suffix to keep zsh specific alias syntax seperately
export LOG_TS="[$(date --utc --rfc-3339=ns)] "

if [ -d ~/.myalias ]; then
    for afile in ~/.myalias/*.bash
    do
        [ $tracing_enabled -eq 1 ] && echo $LOG_TS"Sourcing ${afile} ..."
        source $afile
    done
    unset afile
fi

if [ -d ~/.myfunc ]; then
    for ffile in ~/.myfunc/*.bash
    do
        [ $tracing_enabled -eq 1 ] && echo $LOG_TS"Sourcing ${ffile} ..."
        source $ffile
    done
    unset ffile
fi
