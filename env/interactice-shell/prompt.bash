#/usr/bin/env sh
# To cutomize the prompt string left & right

get_branchname(){
  git branch 2>/dev/null | awk '/\*/{print $2}'
}


export PROMPT="%F{154}%n%f@%F{011}%m%F{010}%#%f "

export RPROMPT=" %F{010}[%F{011}%~ %F{154}%*%F{010}]"
