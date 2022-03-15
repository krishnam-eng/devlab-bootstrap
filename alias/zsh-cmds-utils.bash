#########
#     Shell Level Actions
#########

# Quick access to the .zshrc file
alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc'

# Load zsh rc
alias lzsh="exec zsh -l"

#########
#     Directory Level Actions
#########

# make dir and create the intermediate parent directories if needed
alias mkd="mkdir -p"

# remove "d"ir
alias rmd="\rm -rf"

# copy "d"ir recursively with verbose mode
alias cpd="cp -rv"

# copy current dir name
alias cpname=" echo $PWD | pbcopy"

# navigate dir - go up one to five steps
alias u.="cd .."
alias u..="cd ../.."
alias u...="cd ../../.."
alias u....="cd ../../../.."
alias u.....="cd ../../../../.."
alias u1="cd .."
alias u2="cd ../.."
alias u3="cd ../../.."
alias u4="cd ../../../.."
alias u5="cd ../../../../.."


#########
#      Network / IO
#########
alias ipe='curl ipinfo.io/ip'      # IP External
alias ipi='ipconfig getifaddr en0' # IP Internal - local

########
#     Misc
########
alias hA='history 1' # show all history starting index 1
alias hs='history | grep'
alias hsi='history | grep -i'

alias utc='date -u'

#######
#    Others
#######

# copy after dereferencing "l"inks
alias cpl="cp -L"

# smart grep with default exclution filter
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git} '

alias tf='tail -f'

alias sdump='find . -name "*dump"'



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

# shows the number of files that a user can have opened per login session
alias filelimit="cat /proc/sys/fs/file-max"
