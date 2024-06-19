#!/usr/bin/env bash

# Add Homebrew's executable directory to the front of the PATH
export PATH=/usr/local/bin:${PATH}

if [ -d "$HOME/bin" ] ; 
then
  PATH="$PATH:$HOME/bin"
fi

# dev lab path
if [ -d "$HOME/hrt/bin" ]
then
  PATH="$PATH:$HOME/hrt/bin"
fi

# All GNU commands have been installed with the prefix "g" (e.g. ggrep, gdate, gecho)
# If you need to use these commands with their normal names, you
# can add a "gnubin" directory to your PATH from your bashrc like:
if [ -f /usr/local/opt/coreutils/libexec/gnubin ]; then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi