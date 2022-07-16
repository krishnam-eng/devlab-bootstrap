#/usr/bin/env sh
# To cutomize the prompt string left & right

get_branchname(){
  git branch 2>/dev/null | awk '/\*/{print $2}'
}

shorthost=$(hostname | sed -e 's/BA.*//')

export PROMPT="%F{154}%n%f@%F{011}${shorthost}%F{010}%#%f "

export RPROMPT="%(?.%F{green}%h √.%F{red}%h) %F{010}[%F{011}%~ %F{154}%*%F{010}]"
