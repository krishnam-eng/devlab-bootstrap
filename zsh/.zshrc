#!/usr/bin/env zsh

################
# description : This script (known as _startup file_) will be executed by zsh and all my zsh preferences goes here
# zsh_version : 5.8 (zsh --version)
# author	    : krishnam
################

###############
# init
#   some people so adament to be first in the line. And Powerlevel10k is such one.
###############
# echo 'zsh run config...'

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/hrt/hldr/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# When using Powerlevel10k with instant prompt, console output during zsh initialization may indicate issues.
# Suppress this warning either by running p10k configure or by manually defining the following parameter:
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# load prompt config here instead in zshenv to make sure nothing else overrides my prompt
source ~/hrt/hldr/env/interactice-shell/prompt.bash

# load venv extention config to work with python projects
# source ~/hrt/hldr/venv/virtualenvwrapper.sh

###############
# pre-launch cmds to get you ready to rock
###############

# add private keys (from default location ~/.ssh/) to ssh agent (Please note it works only if the passphrase is not set). I know it is not pretty! Tip: keep private key with passphrase in non default location so that it won't prompt you to give passphrase. 

ssh-add &>/dev/null

################
#                Expansions
#
#         Alias Expansion
#   ${}   Parameter Expansion  [ e.g a=cat ; echo ${a}man => catman
#   $()   Command Substitution [ echo $(date)
#   $(()) Arithmetic Expansion [ echo $[4/2] - 2
#   {}    Brace Expansion      [ e.g %echo c{a,o,u}t => cat cot cut, %echo {1..5} => 1 2 3 4 5
#   !     History Expansion
#   *?[]^ Filename Generation  or Globbing as in Global Substitution
#         Process Sub          [ => > < >> | , tee
#         Filename Exp         [ ~ , =ls , ~customshortname
#         Process Sub          [ => > < >> | , tee#
###############

##############
#               Globbing
#
# Basic
#      * - wildcard - any chars
#      ? - any single char        [ ls script.?? > script.sh
#     [] - bracket for a sequance of chars. supports char set also like [[:alpha:]]*
#      ^ - avoid [^o] - no o
# Extended
#    **/ - recursive searching in child dirs  [ **/*.md - it matchs all md files in child dir also
#   ***/ - recursive searching including links   [  ***/*.md - it matchs all md files including links
#    (|) - alternate pattern [  *.(bash|zsh) matchs both script files
#    <-> - numeric ranges    [ log_<10-20>.txt
#     ~  - should not match [ b*~*.o - file start with b and do nto have .o in it
#     ^  - caret and tilde does the same - operator for negating
# Qualifier
#     (/) - dir
#     (.) - file
#     (@) - link
#     (rwx) - read, write, execute
#     (o) - order n- name, L- size , m- modified
#     (O) - Reverse sort
#  Time Qualifier
#     (mh-1) -  modified in last 1h
#     (ch-1) -  created in last 1h
#     (ah-1) -  accessed in last 1h
#     h, m, w, M - hour, min, week, Month
# File Size Qualifier
#     (L[kmg][+-]size) kb, mb, gb, larger than, smaller than
###############
# echo 'Globbing...'

# do not show "no matches found:..."
setopt null_glob

# do nto show "no bad pattern" either
setopt no_bad_pattern

# make it similar to bash - in case of any nomatch, pattern will be treated as string
unsetopt nomatch

# enable extened globbing. this enables cool features like recursive seraching "**/"
setopt EXTENDED_GLOB

# Bulk rename utility - works based on pattern
autoload -Uz zmv # e.g zmv '(*)_(*)' 'out_$2.$1', use -n option to do dry-run


###############
# Load Aliases & Functions
#     to make life easy
#
#     Create: alias name="expand to this"
#            Unset : unalias name
#     Global: alias -g chars   - not just for cmd replacement. just replace anywhere in the full cmd.
#     Suffix: alias -s         -  open file based on suffix
#     Hash  : hash -d namedir=/path/to/dir
##############
# echo 'Load Aliases and Functions...'

# load all alias files with `source filename` or `. filename` (. is posix std way)
 if [[ -d ~/hrt/hldr/alias ]]; then
  for afile in ~/hrt/hldr/alias/*sh
  do
    # echo $LOG_TS"Sourcing ${afile} ..."
    source $afile
  done
  unset afile
 fi

 if [[ -f ~/hrt/private/alias.zsh ]]; then
   source ~/hrt/private/alias.zsh
 fi

# todo: make them as lazy load using auto load capability or set it in fpath
if [ -d ~/hrt/hldr/func ]; then
  for ffile in ~/hrt/hldr/func/*sh
  do
    # echo $LOG_TS"Sourcing ${ffile} ..."
    source $ffile
  done
  unset ffile
fi

# Extending your fpath
#
# test and enable the below
# fpath=(~/.myfunc $fpath)

################
# Working with History
#   make myshell remember like elephant
#
#
#  Previous Command
#     **Event Designator(!) + Word Designators(*, ^, $ - like regex style)**
#       !! -> previously run command (e.g, if sudo is missed, instead retying all, use `sudo !!`)
#       !* -> All Args of the prev. cmd (e.g, `ls /var/zxv.f ; stat !*`)
#       !^ -> First Arg of the prev. cmd (e.g, `ls /var/zxv.f xyx.txt ; stat !^`)
#       !$ -> Last Arg of the prev. cmd (e.g, `ls /var/zxv.f xyx.txt ; stat !$`)
#
#  Search History
#     !<hist.number> -> n th cmd in hist use '-' to count backward
#     !<match.str> -> last cmd executed which had this 'str'
#
#  Substitution
#     ^history-entry^word-replacement
################
# echo 'History Configuration...'

if [[ -f ~/hrt/history/shell/ ]]; then
    mkdir -p ~/hrt/history/shell/
fi
HISTFILE=~/hrt/history/shell/.zhistfile # up or down to navigate history or use CTR+R to search history
HISTSIZE=100000
SAVEHIST=100000 # hist won't be _saved_ with out this conf

# To save unexecuted cmd to history, make the command as comment by prefixing # and executing
setopt interactivecomments

# set histchars='@^#' if you want to change default char '!'

# to avoid blind faith during history expansion, Don't execute immediately upon history expansion.
setopt HIST_VERIFY

# saves timestamp and duration for each history entry run. excellent for data analysis
setopt EXTENDED_HISTORY

# If a new command line being added to the history list duplicates an older one, the older command is removed from the list
setopt HIST_IGNORE_ALL_DUPS

# When searching for history entries in the line editor, do not display duplicates of a line previously found, even if the duplicates are not contiguous.
setopt HIST_FIND_NO_DUPS

# reduce extra spaces and tabs from history entries
setopt HIST_REDUCE_BLANKS

# add entries to the history as they are typed instead of waiting shell to exit. I know you want this.
setopt INC_APPEND_HISTORY

# share history between different zsh processes
setopt SHARE_HISTORY

##############
#  Auto Completion & Some More Magic
#
#     Tab to start the auto-complete, tab-again to cycle-through
#
#   types:
#       filname/dir      [ str<Tab>
#       external command [ str<Tab>
#       built-in command [ str<Tab>
#       command option   [ -<Tab>
#       env variables    [ $str<Tab>
#       alias            [ str<Tab>
#       function         [ str<Tab>
#       expanding cmd    [ echo `which zsh`<Tab> => echo /usr/bin/zsh
#       kill             [ menu to select process id
#
#   you can see where this is going
#
##############
# echo 'Auto Completion & Some More Magic Setup...'

# Load auto completion feature
autoload -Uz compinit
compinit -u # https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories

# Enable auto complete for kubectl
if [[ -f /usr/local/bin/kubectl ]];then
  source <(kubectl completion zsh)
fi

# add more flair to your auto complete sugesstions, by grouping them by type
zstyle ':completion:*' group-name ''

# enable menu selection from the guess list
zstyle ':completion:*' menu select=1

# show command options with description and make it easy to move around too with double Tab
zstyle ':completion:*' verbose yes

# Change dir by just hitting enter on dir name
setopt autocd

# Move cursor inbetween incomplete word and type
setopt completeinword

# Suggest mis-spelled commands
setopt correct

# type cmd and pressing spacebar now triggers history expansion. e.g. echo !!<Space> => echo ls
bindkey ' ' magic-space

#####################
#         Redirection & MultiOS
#
####################

# To prevent stdout or stderr (1> or 2>) redirection to existing file, use append >>
setopt noclobber
#o enable multiple output stream
setopt multios

# Building Dir Stack
# pushd ~/mylib &>/dev/null
# pushd /etc &>/dev/null
# pushd /var &>/dev/null
# alias sd="pushd" # switch dir using dir stack
### CLOSE: Dir Nav

### To list the values of ....., run the below
# todo: move to ls.bash file
#  %setopt ; unsetopt -> zsh options
#  %alias
#  %functions ; echo $fpath;
#  %enable ; diable -> bulit-in commands
#  %hash -> named dirs
#  %dirs -> dir stack
#  %echo $- => shows zsh options
#  %echo $PROMPT
###

############
# ZLE
#
#   The Zsh Line Editor allows you to define your own key bindings and set of custom keymaps (collections of key bindings) in addition to extending predefined entries.
#
# From EMACS Keybindings
#
# Move
#   Ctrl + A Moves the cursor to the beginning of the line
#   Ctrl + E Moves the cursor to the end of the line
#
#   Esc + B Moves the cursor backwards one word
#   Esc + F Moves the cursor forward one word
#
# Delete
#   Ctrl + U Deletes the whole line
#   Ctrl + K Kills (or deletes) until the end of the line
#
#   Esc + Backspace Deletes one word on the left of the cursor
#   Esc + D Deletes one word on the right of the cursor
#   Ctrl + W Deletes the whole word backwards from the cursor location
#
#   Ctrl + D Deletes a character (moves forward) / lists completions / logs out
#
# Yank
#   Ctrl + Y Yanks the last killed word
#   Esc + Y Switches the last yanked word
#
# Swap
#   Ctrl + T Transposes two characters
#   Esc + T Transposes two words
#
# Search
#   Ctrl + R Incremental search backwards
#   Ctrl + S Incremental search forwards (automatically enables NO_FLOW_CONTROL option)
#   Esc  + < go to very beginning of our history file
#
# Execute Mode
#  Esc + x  - open cmd mode: ctr+shit+p in vscode  or : in tmux
#     where-is mode
#
#  use `bindkey -L` to list all current bindings
#  todo: -L and find useful commands - take a print
#  use `bindkey -l` to view avilable keymaps
#
##################

# By default zsh relies on $EDITOR & $VISUAL to guess the binding. Don't guess now.(use -v for vi mode
bindkey -e
# skip beeping on errors.
setopt NO_BEEP


################
#   Prompt Style & Theme
#
#       better be the last bencher
################

# Load prompt module
#   To use predefined prompt configs >prompt -p to view all themes
#     e.g prompt adam1 yellow
autoload -Uz promptinit
promptinit

# treat $PROMPT just as if it were vanilla shell variable - will be checked against for command substitution, parameters and arithmetic expanstion
setopt PROMPT_SUBST

# use below for enabling custom promt
# source ~/.myenv/interactive_shell/prompt.zsh

# To customize prompt, run `p10k configure` or edit ~/.myzsh/.p10k.zsh.
autoload -Uz is-at-least
is-at-least 5.1 && [[ -f ~/hrt/hldr/zsh/.p10k.zsh ]] && [[ -f ~/hrt/ctrflags/enablepowertheme ]] && source ~/hrt/hldr/zsh/.p10k.zsh
is-at-least 5.1 && [[ -f ~/hrt/style/powerlevel10k/powerlevel10k.zsh-theme ]] && [[ -f ~/hrt/ctrflags/enablepowertheme ]] && source ~/hrt/style/powerlevel10k/powerlevel10k.zsh-theme

#### like Fish Shell
# enable syntax highlighting like fish-shell - make it easy to spot syntax and fix syntax before executing
[[ ! -f ~/hrt/style/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] || source ~/hrt/style/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Fish-like fast/unobtrusive autosuggestions for zsh.
[[ ! -f ~/hrt/style/zsh-autosuggestions/zsh-autosuggestions.zsh ]] || source ~/hrt/style/zsh-autosuggestions/zsh-autosuggestions.zsh
