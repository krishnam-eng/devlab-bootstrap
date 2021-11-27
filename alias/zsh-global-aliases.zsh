####
# Global aliases are defined using the -g flag. A global alias is aggressive. Once registered, it replaces all occurrences of the alias name with the specified command.
#   The pattern:
#     $ alias -g aliasName="command"
#     $ usage: xcmd aliasName
####

# shows the number of files that a user can have opened per login session
alias filelimit="cat /proc/sys/fs/file-max"

if [ "$ZSH_SHELL"="zsh" ]; then

  alias -g H='| head'
  alias -g T='| tail'
  alias -g M="| more"
  alias -g L="| less"
  alias -g G='| egrep'
  alias -g R='| lolcat'

  alias -g EH='|& head'
  alias -g ET='|& tail'
  alias -g EG='|& egrep'
  alias -g EL='|& less'


  # Recepie: Skipping a header in a file
  #   tail: -n +2 will skip first line and give everything else  (offset from top)
  #   tail: -n 2 will give last two line (offset from end)

  # override file even if noclobber is set to true "Write it anyway !"
  alias -g W='>|'
  alias -g R="<" # read from
  alias -g DN="2>/dev/null"  # throwing output away

  # Sending output and error messages to the same file
  alias -g CA="2>&1 | cat -A"
  alias -g OE=">&"
  alias -g MOE=">& | more"


  # Recipe: Saving a Copy of Output Even While Using It as Input
  # use what plumbers call a T-joint in the pipes. For
  # bash, that means using the tee command to split the output into two identical
  # streams, one that is written to a file and the other that is written to standard output
  alias -g D='| tee /tmp/tee.log' # to debug a long sequance of piped i/o


  # Running Several Commands in Sequence
  alias -g OR="||" # Executes second part only when failure occurs in first part
  alias -g AND="&&" # Running a Command Only if Another Command Succeeded

  alias -g ...='../..'
  alias -g ....='../../..'
  alias -g .....='../../../..'

  alias -g C='| wc -l'
  alias -g NS='| sort -n'
  alias -g RNS='| sort -nr'
  alias -g S='| sort'
  alias -g US='| sort -u'

  alias -g X0G='| xargs -0 egrep'
  alias -g X0='| xargs -0'
  alias -g XG='| xargs egrep'
  alias -g X='| xargs'
fi

# Recipe: Telling Whether a Command Succeeded or Not
#   Command Execution Exist STatus: The exit status of a command is kept in the shell variable referenced with $?. Its value can range from 0 to 255. Script can set exit status like `exit 2`
alias est="echo $?"

# Getting user input
#   -p => print a prompt string before reading the input, -t => sets a timeout, e prfix indicates enchance convention
# Recipe: Prompting for a Password
#   -s => silent mode
alias eread="read -t 5 -p"

# Recipe: Running a Command Only if Another Command Succeed
#   use1: cmd1 && cmd2
#   use2: set -e; cd mytemp;rm* => Running a Command Only if Another Command Succeed

# Recipe: Running Long Jobs Unattended
#   use: & to run in the background
