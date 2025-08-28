# Pre-steps
# ln -sf "$HOME/sbrn/sys/hrt/conf/zsh/.zshenv" ~/.zshenv
# ln -sf "$HOME/sbrn/sys/hrt/conf/zsh" "$HOME/sbrn/sys/config/zsh"
# ln -sf "$HOME/sbrn/sys/hrt/conf/git" "$HOME/sbrn/sys/config/git"

# XDG Base Directory Specification paths
# Cross-Desktop Group standard for organizing user files
export XDG_CONFIG_HOME="$HOME/sbrn/sys/config"

# Set zsh configuration directory
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export XDG_DATA_HOME="$HOME/sbrn/sys/local/share" 
export XDG_STATE_HOME="$HOME/sbrn/sys/local/state"
export XDG_CACHE_HOME="$HOME/sbrn/sys/cache"

# Application-specific XDG compliance
export LESSHISTFILE="$XDG_STATE_HOME/less_history"
export ANDROID_HOME="$XDG_DATA_HOME/android"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
