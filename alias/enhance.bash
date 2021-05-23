######
# Enhance existing commands and builtins 
#   
#   by setting default preferable options
#
###### 

##########===========----------------
# enhanced dir cmds (make,copy...) with built-in
##########===========----------------

# creat the intermediate parent directories if needed
alias emkdir="mkdir --parents"

# creat the intermediate parent directories if needed
alias ecp="cp -rv --parents"

# copy "d"ir recursively with verbose mode
alias cpd="cp -rv"

# copy after dereferencing "l"inks
alias cpl="cp -L"

# remove "d"ir recursively
alias rmd="\rm -rf"

##########===========----------------
# enhanced ls with built-in
##########===========----------------

# Dot: Showing All Hidden (Dot) Files in the Current Directory
# add -l for long list
alias l.='ls -d .*'

# All: long list,show almost all,show type,human readable (with dot files)
alias la="ls -lABFXh --block-size=K"

# Recursive: sorted by date,recursive,show type,human readable
alias lr='ls -tRFh'

# Tree: use tree like ls , -a => all , -prune => no empty dir , -L 2 => 2 level
alias lt="tree "
alias lt1="tree -L 1"
alias lt2="tree -L 2"
alias lt3="tree -L 3"
alias lt4="tree -L 4"

# Order: with Size and Sorted
alias lo='ls -1FSsh'

# ls for machince read (all files and full timestamp
alias lm="ls -aFXZ --full-time  --sort=size --block-size=KiB -n"

# List all env
alias lsenv="declare -p" # or use 'export -p' or 'env' to see all exported variables

# List all variables
alias lsvar="set"

# List all gh
alias lsgh="lt1 ~/github/"

# List node installed packages
alias lsnd="lt1 ~/kroot/node/bin"

# List all my dir
alias lsmy="lt1 ~/.my*"

# list shells & you can change shell chsh -s /path
alias lssh="cat /etc/shells"

# Other useful options
# -1 => print in one column

##########===========----------------
# enhanced ls with exa
##########===========----------------

alias els="exa"

alias eld="exa -ld .*"

alias ela="exa --long"

alias elo="exa -l --header -s"

alias elr="exa --recurse"

alias elg="exa --long --header --git"

alias elm="exa --long --extended"

alias elt="exa --tree --long"

alias elt1="exa --tree --long --level=2"
alias elt2="exa --tree --level=2 --long"
alias elt3="exa --tree --level=3 --long"
alias elt4="exa --tree --level=4 --long"

##########=======-----LS END-----======##########

# use default edit as nano & frquent edit files
alias e="nano"

# Quick access to the .zshrc file
alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc' 

# smart grep with default exclution filter
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git} '

alias tf='tail -f'

# clear dump files using cmd substitution
# The earlier shell syntax was to use backquotes (``) instead of $() for enclosing the sub-command. The $() syntax is preferred over the older `` syntax because it is easier to nest and arguably easier to read
alias cdump="rm $(find . -name "*dump")"
alias sdump='find . -name "*dump"'

#alias dud='du -d 1 -h'
#alias duf='du -sh *'

# find file
alias ffl='find . -type f -name'

alias h='history'
#alias hgrep="fc -El 0 | grep"
alias help='man'
#alias sortnr='sort -n -r'
#alias unexport='unset'

#########################
# Replacing Builtins and External Commands
#
# enable -a will list all builtins and their enabled or disabled status.
########################

#######################
# Change Dir
######################
ecd () {
    builtin cd "$@"
    echo "${LOG_TS} ${CS_yellow}$OLDPWD${CS_reset} --> ${CS_bcyan}$PWD${CS_reset}"
    gitvenv
}

# go up one to five steps
alias u.="cd .."
alias u..="cd ../.."
alias u...="cd ../../.."
alias u....="cd ../../../.."
alias u.....="cd ../../../../.."

#######################
## Func
#######################

# Determining if You Are Running Interactively
# $- is a string listing of all the current shell option flags 
# is_interactive ; echo $!
is_interactive(){
    case "$-" in
        *i*) return 1;;
        *) return 0;;
    esac
}

alias rcat="lolcat"

###########
# Others 
#############

alias ewatch="watch -d"

