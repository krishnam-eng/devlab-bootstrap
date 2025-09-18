#!/usr/bin/env zsh
# ZSH Functions Integration
# Description: Main integration point for loading function modules

# Set the functions directory path
export ZSH_FUNCTIONS_DIR="${ZDOTDIR:-$HOME/.config/zsh}/functions"

# For your current setup, override the path
if [[ -d "$HOME/sbrn/sys/hrt/conf/zsh/functions" ]]; then
    export ZSH_FUNCTIONS_DIR="$HOME/sbrn/sys/hrt/conf/zsh/functions"
fi

# Load the function loader system
if [[ -f "$ZSH_FUNCTIONS_DIR/_loader.zsh" ]]; then
    source "$ZSH_FUNCTIONS_DIR/_loader.zsh"
    
    # Load all function modules
    load_zsh_functions
else
    echo "❌ Function loader not found: $ZSH_FUNCTIONS_DIR/_loader.zsh"
fi