# frequently used dirs
source ~/github/ohmy-linux/zsh/namedir.sh

#alias
source ~wsrepo/alias/enhance.alias
source ~wsrepo/alias/git.alias
source ~wsrepo/alias/tmux.alias
source ~wsrepo/alias/launch.alias
source ~wsrepo/alias/lang.alias

# functions
source ~wsrepo/func/colorama.sh
source ~wsrepo/func/basic.sh


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

# History shortcuts / expansion
alias hist="history"
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


### START: List & View alias
#ls for machince read
alias lm="ls -aFXZ --color=always --full-time  --sort=size --block-size=KiB -n"

#ls for human read
alias lh="ls -ABFX --color=always --block-size=K -l"

#ls for normal use
alias ls="ls -ABFX --color=always --width=80"

# use tree like ls , -a => all , -prune => no empty dir , -L 2 => 2 level 
alias lt="tree -a -L 1"
alias lt2="tree -a -L 2"
alias lt3="tree -a -L 3"
alias lt4="tree -a -L 4"
alias lt5="tree -a -L 5"

### CLOSE: List & View alias


### Load alias files
#
#
source ~/.myalias/tmux.alias
###

### Functions
# Listing the prompt colors
function pcolors() {
  for color in {000..255}; do
    print -P "$color: %F{$color}████ Foreground %f%K{$color} Background %k"
  done
}

### To get about the given command or file or dir, run the below
# which
# type
# stat
alias what="whence -w" # -f option will give the function value 
###

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
