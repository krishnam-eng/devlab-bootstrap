######
# Enhance existing commands and builtins 
#   
#   by setting default preferable options
#
###### 

# creat missing dirs in the path
alias emkdir="mkdir -p"

##########===========----------------
# enhanced ls with built-in
##########===========----------------

# ls - set color option
alias ls="ls --color=always --width=80"

# Dot: Showing All Hidden (Dot) Files in the Current Directory
# add -l for long list
alias ld='ls -d .*'

# All: long list,show almost all,show type,human readable (with dot files)
alias la="ls -lABFXh --block-size=K"

# Recursive: sorted by date,recursive,show type,human readable
alias lr='ls -tRFh'

# Tree: use tree like ls , -a => all , -prune => no empty dir , -L 2 => 2 level
alias lt="tree -a"
alias lt1="tree -a -L 1"
alias lt2="tree -a -L 2"
alias lt3="tree -a -L 3"
alias lt4="tree -a -L 4"

# Order: with Size and Sorted
alias lo='ls -1FSsh'

# ls for machince read (all files and full timestamp
alias lm="ls -aFXZ --full-time  --sort=size --block-size=KiB -n"


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


# list shells & you can change shell chsh -s /path
alias lshells="cat /etc/shells"


# Quick access to the .zshrc file
alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc' 

# set color to grep
alias grep='grep --color'

# smart grep with default exclution filter
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git} '

alias t='tail -f'

# clear dump files using cmd substitution
# The earlier shell syntax was to use backquotes (``) instead of $() for enclosing the sub-command. The $() syntax is preferred over the older `` syntax because it is easier to nest and arguably easier to read
alias cdump="rm $(find . -name "*dump")"
alias sdump='find . -name "*dump"'

# list 

#alias dud='du -d 1 -h'
#alias duf='du -sh *'

#alias ff='find . -type f -name'

#alias h='history'
#alias hgrep="fc -El 0 | grep"
#alias help='man'
#alias p='ps -f'
#alias sortnr='sort -n -r'
#alias unexport='unset'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

#########################
# Replacing Builtins and External Commands
#
# enable -a will list all builtins and their enabled or disabled status.
########################

cd () {
    builtin cd "$@"
    echo "${CS_yellow}$OLDPWD${CS_reset} --> ${CS_bcyan}$PWD${CS_reset}"
}

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
