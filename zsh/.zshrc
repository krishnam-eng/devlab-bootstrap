# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.myzsh//.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

################
#description : This script will be executed by zsh
#zsh_version : 5.8 (zsh --version)
#author	     : krishnam
################

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

### START: Automation
# Auto completion
autoload -Uz compinit
compinit # Tab to start the auto-complete, tab-again to cycle-through
setopt completeinword # Move cursor inbetween incomplete word and type

# Suggest mis-spelled commands
setopt correct

# Change dir by just hitting enter on dir name
setopt autocd

# Bulk rename utility
autoload -U zmv # e.g zmv '(*)_(*)' 'out_$2.$1', use -n option to do dry-run

### CLOSE: Automation

### START: Redirection & MultiOS
# To prevent stdout or stderr (1> or 2>) redirection to existing file, use append >>
setopt noclobber
#o enable multiple output stream
setopt multios
### CLOSE: Redirection & MultiOS

### START: Command History
# up or down to navigate history or use CTR+R to search history
HISTFILE=~/.myzsh/.zhistfile
HISTSIZE=1000
SAVEHIST=1000

# To save unexecuted cmd to history, make the command as comment by prefixing # and executing
setopt interactivecomments

# !! -> previously run command (e.g, if sudo is missed, instead retying all, use `sudo !!`)
# !* -> Args given to prev. cmd (e.g, `ls /var/zxv.f ; stat !*`)
# !$number -> n'th cmd in hist
# $_ -> Last Arg in the prev.cmd
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

source ~/.myenv/profile/prompt.zsh 
source /home/krishnam/kroot/themes/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.myzsh//.p10k.zsh.
[[ ! -f ~/.myzsh//.p10k.zsh ]] || source ~/.myzsh//.p10k.zsh
