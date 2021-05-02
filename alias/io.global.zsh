# exist status
alias est="echo $?"

####
# Global aliases are defined using the -g flag. A global alias is aggressive. Once registered, it replaces all occurrences of the alias name with the specified command.
#   The pattern:
#     $ alias -g aliasName="command"
#     $ usage: xcmd aliasName
####

if [ "$ZSH_SHELL"="zsh" ]; then
  # Sending output and error messages to the same file
  alias -g OE=">&"
  alias -g H='| head'
  alias -g T='| tail'
  alias -g G='| grep'
  alias -g M="| more"
  alias -g MOE=">& | more"  # send both STDOUT and STDERR
  alias -g L="| less"
  alias -g NE="2>/dev/null"  # throwing output away
  alias -g R='| lolcat'
  alias -g D='| tee /tmp/tee.log' # to debug a long sequance of piped i/o
fi

# Other useful options
#   tail: -n 2 will give last two line (offset from end)
# Skipping a header in a file
#   tail: -n +2 will skip first line and give everything else  (offset from top)

