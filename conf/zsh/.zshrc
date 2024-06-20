#!/usr/bin/env zsh

# Order of loading the extensions is important
source $HOME/Paradigm/Development/Root/conf/zsh/extensions/p10k-instant-prompt.zsh

# Load the zsh run configuration and tools specific init run configurations
source $HOME/Paradigm/Development/Root/conf/zsh/util/execute-run-configs.zshrc

# Zsh auto-suggestions, syntax highlighting, and history substring search
source $HOME/Paradigm/Development/Root/conf/zsh/extensions/act_like_fish_shell.zsh

# Load p10k configurations and theme if enabled
source $HOME/Paradigm/Development/Root/conf/zsh/extensions/p10k-theme-loading.zsh