#!/usr/bin/env bash
# brew install coreutils
# All GNU commands have been installed with the prefix "g" (e.g. ggrep, gdate, gecho)
#
# If you need to use these commands with their normal names, add a "gnubin" directory to your PATH which
# will then contain symlinks without the "g" prefix.
if [ -d /usr/local/opt/coreutils/libexec/gnubin ]; then
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

# Add Homebrew's executable directory to the front of the PATH
PATH="/usr/local/bin":${PATH}

if [ -d "$HOME/bin" ] ; 
then
  PATH="$PATH:$HOME/bin"
fi

# dev lab path
if [ -d "$HOME/Paradigm/Development/Tools/bin" ]
then
  PATH="$PATH:$HOME/Paradigm/Development/Tools/bin"
fi

export PATH
