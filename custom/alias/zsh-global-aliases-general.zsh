####
# Global aliases are defined using the -g flag. A global alias is aggressive. Once registered, it replaces all occurrences of the alias name with the specified command.
#   The pattern:
#     $ alias -g aliasName="command"
#     $ usage: xcmd aliasName
####

alias -g H='| head'
alias -g T='| tail'
alias -g M='| more'
alias -g L='| less'
alias -g J='| jq .'    # json pretty print - colorful output
alias -g R='| lolcat'
alias -g G='| egrep'
alias -g GW='| egrep -w' # grep for a word (not partial match)


alias -g EH='|& head'
alias -g ET='|& tail'
alias -g EG='|& egrep'
alias -g EL='|& less'

# Sending output and error messages to the same file
alias -g OE=">&"
alias -g OE=">& | more"

# Running Several Commands in Sequence
alias -g OR="||" # Executes second part only when failure occurs in first part
alias -g AND="&&" # Running a Command Only if Another Command Succeeded

alias -g X='| xargs'
alias -g X0G='| xargs -0 egrep'
alias -g X0='| xargs -0'
alias -g XG='| xargs egrep'

alias -g C='| wc -l'

alias -g S='| sort'
alias -g US='| sort -u'
alias -g NS='| sort -n'
alias -g RNS='| sort -nr'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# override file even if noclobber is set to true "Write it anyway !"
alias -g W='>|'
alias -g R="<" # read from
alias -g NO="2>/dev/null"  # throwing output away - no output

# Recipe: Saving a Copy of Output Even While Using It as Input
# use what plumbers call a T-joint in the pipes. For
# bash, that means using the tee command to split the output into two identical
# streams, one that is written to a file and the other that is written to standard output
alias -g D='| tee /tmp/tee.log' # to debug a long sequance of piped i/o


alias -g CA="2>&1 | cat -A"

# Recepie: Skipping a header in a file
#   tail: -n +2 will skip first line and give everything else  (offset from top)
#   tail: -n 2 will give last two line (offset from end)