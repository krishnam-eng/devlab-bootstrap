################
#   Prompt Style & Theme
#
################

# Load prompt module
#   To use predefined prompt configs >prompt -p to view all themes
#     e.g prompt adam1 yellow
autoload -Uz promptinit
promptinit

# treat $PROMPT just as if it were vanilla shell variable - will be checked against for command substitution, parameters and arithmetic expanstion
setopt PROMPT_SUBST

get_branchname(){
  git branch 2>/dev/null | awk '/\*/{print $2}'
}

shorthost=$(hostname | sed -e 's/BA.*//')

export PROMPT="%F{154}%n%f@%F{011}${shorthost}%F{010}%#%f "

export RPROMPT="%(?.%F{green}%h √.%F{red}%h) %F{010}[%F{011}%~ %F{154}%*%F{010}]"