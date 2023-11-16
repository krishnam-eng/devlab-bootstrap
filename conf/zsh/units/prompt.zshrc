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