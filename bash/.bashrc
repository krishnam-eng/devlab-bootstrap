################=============================----------------------------
#description  : This script will be executed by bash 
#bash_version : 5.1.4(1)-release
#author	     : krishnam
################=============================----------------------------

tracing_enabled=0

########=============================----------------------------
# source global definitions (if any)
########=============================----------------------------
if [ -f /etc/bashrc ]; then 
  . /etc/bashrc
fi

defaultsdir=/usr/local/lib/initfiles
if [ -r $defaultsdir/system-bashrc ]; then 
  . $defaultsdir/system-bashrc
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

######## 
# completion 
########

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# Set the default editor
export EDITOR=nano

######## 
# colors 
########

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

######## 
# History 
########

# Don't put duplicate lines in the history and do not add lines that start with a space
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it so if you start a new terminal, you have old session history
shopt -s histappend

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

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

[ -z "$TMUX" ] && export TERM=xterm-256color

# use this for log prefix

if [ -d ~/.myenv ]; then
  # Recipe: Running All Scripts in a Directory
  for efile in ~/.myenv/*.bash
  do
    source $efile
  done
  unset efile
fi

export LOG_TS="${CS_byellow}[${CS_yellow}$(date --utc --rfc-3339=ns)${CS_byellow}] ${CS_reset}"

if [ -d ~/.myalias ]; then
    for afile in ~/.myalias/*.bash
    do
        #[ $tracing_enabled -eq 1 ] && echo $LOG_TS"Sourcing ${afile} ..."
        source $afile
    done
    unset afile
fi

if [ -d ~/.myfunc ]; then
    for ffile in ~/.myfunc/*.bash
    do
        #[ $tracing_enabled -eq 1 ] && echo $LOG_TS"Sourcing ${ffile} ..."
        source $ffile
    done
    unset ffile
fi
