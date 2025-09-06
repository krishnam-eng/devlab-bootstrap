# Cross-Desktop Group (XDG) Specification for organizing user files to improve portability and reduce clutter in the home directory.
# More info: https://specifications.freedesktop.org/basedir-spec/latest/
export SBRN_HOME="$HOME/sbrn"
export XDG_CONFIG_HOME="$HOME/sbrn/sys/config"

# Zsh by default looks for its configuration files in the home directory.
# By setting the ZDOTDIR environment variable, you can specify a different directory for Zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH="$SBRN_HOME/sys/oh-my-zsh"

export XDG_DATA_HOME="$HOME/sbrn/sys/local/share" 
export XDG_STATE_HOME="$HOME/sbrn/sys/local/state"
export XDG_CACHE_HOME="$HOME/sbrn/sys/cache"

# Application-specific XDG compliance
export LESSHISTFILE="$XDG_STATE_HOME/less_history"
export ANDROID_HOME="$XDG_DATA_HOME/android"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

# Homebrew paths for macOS on ARM
export PATH="$HOME/sbrn/sys/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig"
export DYLD_LIBRARY_PATH="/opt/homebrew/lib"

export ZSH_CUSTOM="$ZSH/custom"