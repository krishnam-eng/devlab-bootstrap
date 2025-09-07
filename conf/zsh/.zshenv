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

# Tool-specific configuration paths
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

# Python environment variables
export CONDARC="$SBRN_HOME/tools/conda/.condarc"

# Application-specific XDG compliance
export MAVEN_CONFIG="$XDG_CONFIG_HOME/maven"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export ANDROID_HOME="$XDG_DATA_HOME/android"

export GIT_CONFIG_GLOBAL="$XDG_CONFIG_HOME/git/config"
export GIT_TEMPLATE_DIR="$XDG_DATA_HOME/git/templates"

export LESSHISTFILE="$XDG_STATE_HOME/less_history"

# AWS, Kubernetes, and Docker configuration paths 
# to comply with XDG Base Directory Specification
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export KUBECONFIG="$XDG_CONFIG_HOME/kube/config"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

## Home Brew
# Disable Homebrew's anonymous usage analytics/telemetry
export HOMEBREW_NO_ANALYTICS=1
# Enable Homebrew environment hints
export HOMEBREW_NO_ENV_HINTS=0
# Auto-cleanup old versions of installed formulae and casks after upgrading
export HOMEBREW_INSTALL_CLEANUP=1
# Set Homebrew auto-update interval to 7 days (default is 24 hours)
export HOMEBREW_AUTO_UPDATE_SECS="604800"
# Set Homebrew directories to comply with XDG Base Directory Specification
export HOMEBREW_CACHE="$XDG_CACHE_HOME/homebrew"
export HOMEBREW_LOGS="$XDG_STATE_HOME/homebrew/logs"
export HOMEBREW_TEMP="$XDG_STATE_HOME/homebrew/tmp"

export PATH="$HOME/sbrn/sys/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Homebrew environment variables
export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig"
export DYLD_LIBRARY_PATH="/opt/homebrew/lib"

# Set default editor to vim
export EDITOR="vim"
export VISUAL="vim"

# If you need to use these commands with their normal names, you can add a "gnubin" directory to your PATH with:
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"