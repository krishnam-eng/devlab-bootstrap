######
# Enhance existing commands and builtins
#
#   by setting default preferable options
#
######

# Load zsh rc
alias zshl="exec zsh -l"

# copy current dir name
alias cpdir=" echo $PWD | pbcopy"

##########===========----------------
# enhanced dir cmds (make,copy...) with built-in
##########===========----------------

# creat the intermediate parent directories if needed
alias emkdir="mkdir -p"

# creat the intermediate parent directories if needed
alias ecp="cp -rv -p"

# copy "d"ir recursively with verbose mode
alias cpd="cp -rv"

# copy after dereferencing "l"inks
alias cpl="cp -L"

# remove "d"ir recursively
alias rmd="\rm -rf"

# use default edit as nano & frquent edit files
alias e="nano"

# Quick access to the .zshrc file
alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc'

# smart grep with default exclution filter
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git} '

alias tf='tail -f'

# clear dump files using cmd substitution
# The earlier shell syntax was to use backquotes (``) instead of $() for enclosing the sub-command. The $() syntax is preferred over the older `` syntax because it is easier to nest and arguably easier to read
# (bug: breaks in mac zsh - 5.8) alias cdump="rm $(find . -name "*dump")"

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

alias utc="date -u"
