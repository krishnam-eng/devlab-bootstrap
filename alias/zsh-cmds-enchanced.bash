######
# Enhance existing commands and builtins
#
#   by setting default preferable options
#
######

# Load zsh rc
alias zshl="exec zsh -l"

#########
#     Directory Level Actions
#########
# make dir and create the intermediate parent directories if needed
alias mkd="mkdir -p"

# copy "d"ir recursively with verbose mode
alias cpd="cp -rv"

# remove "d"ir
alias rmd="\rm -rf"

# navigate dir - go up one to five steps
alias u.="cd .."
alias u..="cd ../.."
alias u...="cd ../../.."
alias u....="cd ../../../.."
alias u.....="cd ../../../../.."

#########
#      Default Options
#########
alias watch="watch -d"
alias history="history"

# history
alias h='history'
alias hA='history 1' # show all history starting index 1
alias hs='history | grep'
alias hsi='history | grep -i'

# copy current dir name
alias cpname=" echo $PWD | pbcopy"

# Quick access to the .zshrc file
alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc'

# copy after dereferencing "l"inks
alias cpl="cp -L"


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



alias utc="date -u"

###########
#        Handy Utils
###########
alias myip="curl http://ipecho.net/plain; echo"