# Cross-Desktop Group (XDG) Specification for organizing user files to improve portability and reduce clutter in the home directory.
# More info: https://specifications.freedesktop.org/basedir-spec/latest/
export SBRN_HOME="$HOME/sbrn"
export XDG_CONFIG_HOME="$HOME/sbrn/sys/config"

# Zsh by default looks for its configuration files in the home directory.
# By setting the ZDOTDIR environment variable, you can specify a different directory for Zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH="$SBRN_HOME/sys/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

export XDG_DATA_HOME="$HOME/sbrn/sys/local/share" 
export XDG_STATE_HOME="$HOME/sbrn/sys/local/state"
export XDG_CACHE_HOME="$HOME/sbrn/sys/cache"

# Python environment variables
export CONDARC="$SBRN_HOME/tools/conda/.condarc"

# Java environment variables 
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Application-specific XDG compliance
export LESSHISTFILE="$XDG_STATE_HOME/less_history"
export ANDROID_HOME="$XDG_DATA_HOME/android"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

# Homebrew paths for macOS on ARM
export PATH="$HOME/sbrn/sys/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig"
export DYLD_LIBRARY_PATH="/opt/homebrew/lib"

# Set default editor to vim
export EDITOR="vim"
export VISUAL="vim"

# If you need to use these commands with their normal names, you can add a "gnubin" directory to your PATH with:
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"