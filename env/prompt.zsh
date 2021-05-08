# To cutomize the prompt string left & right
export PROMPT='%F{154}%n%f@%F{011}%m%F{010}%#%f '

export RPROMPT=' %F{010}[%F{011}%~ %F{154}%*%F{010}]'

# gotcha: this file should be sourced once venv is activated
if [ -v VIRTUAL_ENV ]
then
  venv_name=$(basename $VIRTUAL_ENV)
  export RPROMPT="%F{010}[%F{130}>${venv_name}< %F{011}%~ %F{154}%*%F{010}]"
fi
