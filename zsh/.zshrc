#!/usr/bin/env zsh

################
# description : This script (known as _startup file_) will be executed by zsh and all my zsh preferences goes here
# zsh_version : 5.8 (zsh --version)
# author	    : krishnam
################

###############
# init
#   some people so adament to be first in the line
###############

# Enable Powerlevel10k instant prompt. Should stay close to the top of .zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##############
# Aliases & Functions
#     to make life easy
##############
if [[ -d ~/.myalias ]]; then
  for afile in ~/.myalias/*sh
  do
    # echo $LOG_TS"Sourcing ${afile} ..."
    source $afile
  done
  unset afile
fi

if [ -d ~/.myfunc ]; then
  for ffile in ~/.myfunc/*sh
  do
    # echo $LOG_TS"Sourcing ${ffile} ..."
    source $ffile
  done
  unset ffile
fi

# load prompt config here instead in zshenv to make sure nothing else overrides my prompt
source ~/.myenv/interactice-shell/prompt.bash

# load venv extention config to work with python projects
source ~/.myvenv/virtualenvwrapper.sh


################
# History
#   to remember like elephant
################

# up or down to navigate history or use CTR+R to search history
HISTFILE=~/.myzsh/.zhistfile
HISTSIZE=10000
SAVEHIST=10000

# To save unexecuted cmd to history, make the command as comment by prefixing # and executing
setopt interactivecomments

# History Expansion
#  Previous Command
#     **Event Designator(!) + Word Designators(*, ^, $ - like regex style)**
#       !! -> previously run command (e.g, if sudo is missed, instead retying all, use `sudo !!`)
#       !* -> All Args of the prev. cmd (e.g, `ls /var/zxv.f ; stat !*`)
#       !^ -> First Arg of the prev. cmd (e.g, `ls /var/zxv.f xyx.txt ; stat !^`)
#       !$ -> Last Arg of the prev. cmd (e.g, `ls /var/zxv.f xyx.txt ; stat !^`)
#  Search History
#     !<hist.number> -> n th cmd in hist use '-' to count backward
#     !<match.str> -> last cmd executed which had this 'str'
#  Substitution
#     ^history-entry^word-replacement

# set histchars='@^#' if you want to change default char '!'

# to avoid blind faith during history expansion
setopt HIST_VERIFY

# saves timestamp and duration for each history entry run. excellent for data analysis
setopt EXTENDED_HISTORY

# ignore duplicate when showing results
setopt HIST_IGNORE_ALL_DUPS

# reduce extra spaces and tabs from history entries
setopt HIST_REDUCE_BLANKS

# add entries to the history as they are typed. I know you want this.
setopt INC_APPEND_HISTORY

# share history between different zsh processes
setopt SHARE_HISTORY


########
#  automation / auto load functions
########

# Change dir by just hitting enter on dir name
setopt autocd

# Auto completion
autoload -Uz compinit
compinit # Tab to start the auto-complete, tab-again to cycle-through

# Move cursor inbetween incomplete word and type
setopt completeinword

# Suggest mis-spelled commands
setopt correct

# Load prompt module
#   To use predefined prompt configs >prompt -p to view all themes
#     e.g prompt adam1 yellow
autoload -Uz promptinit
promptinit

# treat $PROMPT just as if it were vanilla shell variable - will be checked against for command substitution, parameters and arithmetic expanstion
setopt PROMPT_SUBST

# Bulk rename utility
autoload -Uz zmv # e.g zmv '(*)_(*)' 'out_$2.$1', use -n option to do dry-run

### START: Redirection & MultiOS
# To prevent stdout or stderr (1> or 2>) redirection to existing file, use append >>
setopt noclobber
#o enable multiple output stream
setopt multios


### CLOSE: Command History

# Building Dir Stack
# pushd ~/mylib &>/dev/null
# pushd /etc &>/dev/null
# pushd /var &>/dev/null
# alias sd="pushd" # switch dir using dir stack
### CLOSE: Dir Nav

###
#PROMPT='%n@%F{green}%m%f %K{red}

### To list the values of ....., run the below
#  %setopt ; unsetopt -> zsh options
#  %alias
#  %functions ; echo $fpath;
#  %enable ; diable -> bulit-in commands
#  %hash -> named dirs
#  %dirs -> dir stack
#  %echo $- => shows zsh options 
#  %echo $PROMPT
###


### Expansions
# 1. Hist Exp
# 2. Alias Exp
# 3. Process Sub => > < >> | , tee
# 4. Param Exp => a=cat ; echo ${a}man => catman
# 5. Cmd Exp => echo ${date}
# 6. Arithmetic Exp  => echo $[4/2] - 2
# 7. Brace Exp => patern into txt e.g %echo c{a,o,u}t => cat cot cut, %echo {1..5} => 1 2 3 4 5,touch
# file_{0..100}
# 8. Filename Exp => path to a file -> ~ , =ls , ~customshortname
# 9. Filename Generation =>  * - any  string , ? - any char , [] any specific chars
###


### Types of Shells
# 1. Login Shell => when you open new terminal
# 2. interactive shell =>  type cmds , login is interatice also
# 3. non-interactive shell => no i/ps taken - run script or cmd %zsh myscript
# echo $- => *i* for interactive
###

# using theme
# source ~/.myenv/interactive_shell/prompt.zsh
source $HOME/kroot/themes/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run p10k configure or edit ~/.myzsh/.p10k.zsh.
[[ ! -f ~/.myzsh/.p10k.zsh ]] || source ~/.myzsh/.p10k.zsh
