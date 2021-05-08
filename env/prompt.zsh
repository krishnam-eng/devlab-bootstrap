# To cutomize the prompt string left & right
export PROMPT='%F{154}%n%f@%F{011}%m%F{010}%#%f '

export RPROMPT=' %F{010}[%F{011}%~ %F{154}%*%F{010}]'

if [ -v VIRTUAL_ENV ]
then
  echo "env is set"
  venv_name=$(basename $VIRTUAL_ENV)
  echo "${venv_name}"
  export RPROMPT="%F{010}[%F{130}>${venv_name}< %F{011}%~ %F{154}%*%F{010}]"
fi
