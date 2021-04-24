####
#  Global aliases are defined using the -g flag. A global alias is aggressive. Once registered, it replaces all occurrences of the alias name with the specified command. 
####

############
# std in out 
#
# > >> (appending) 2>(std err) &>(std out & error)  < (in)
#
# tail: -n 2 will give last two line (offset from end) 
# Skipping a header in a file
# tail: -n +2 will skip first line and give everything else  (offset from top)
############
alias -g R='| lolcat'
alias -g H='| head'
alias -g T='| tail'

alias -g G='| grep'

alias -g M="| more"
alias -g L="| less"
alias -g MOE=">& | more"  # send both STDOUT and STDERR
alias -g NE="2>/dev/null"  # throwing output away
