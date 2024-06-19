#!/usr/bin/env zsh

# initialize
[[ -f $HOME/Paradigm/Development/Flags/enablepowertheme ]] && source $HOME/Paradigm/Development/Root/conf/zsh/extensions/p10k-instant-prompt.zsh

if [ "$(uname)" = "Linux" -o "$(uname)" = "Darwin" ]; then
  for efile in $HOME/Paradigm/Development/Root/conf/zsh/rc.d/*.zshrc
  do
   source $efile
  done
  unset efile
fi

# Extend zsh behavior with fish shell capabilities
source $HOME/Paradigm/Development/Root/conf/zsh/extensions/fish_shell.zsh

# To customize prompt, run `p10k configure` or edit /Users/${USER}/Paradigm/Development/Root/conf/zsh/extensions/.p10k.zsh.
[[ -f $HOME/Paradigm/Development/Flags/enablepowertheme ]] && source /Users/${USER}/Paradigm/Development/Root/conf/zsh/extensions/.p10k.zsh && source /Users/${USER}/Paradigm/Development/Root/Extensions/powerlevel10k/powerlevel10k.zsh-theme

