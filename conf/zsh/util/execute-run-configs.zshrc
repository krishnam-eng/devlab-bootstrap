if [ "$(uname)" = "Linux" -o "$(uname)" = "Darwin" ]; then
  for efile in $HOME/Paradigm/Development/Root/conf/zsh/rc.d/*.zshrc
  do
   source $efile
  done
  unset efile
fi