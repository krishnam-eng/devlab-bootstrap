#!/usr/bin/env zsh

# Define the base directory
BASE_DIR="$HOME/Paradigm/Development"
FLAGS_DIR="$BASE_DIR/Flags"
ROOT_DIR="$BASE_DIR/Root"
EXTENSIONS_DIR="$ROOT_DIR/Extensions"
POWERLEVEL10K_THEME="$EXTENSIONS_DIR/powerlevel10k/powerlevel10k.zsh-theme"
P10K_CONFIG="$ROOT_DIR/conf/zsh/extensions/.p10k.zsh"

# Check if the power theme is enabled
if [[ -f "$FLAGS_DIR/enablepowertheme" ]]; then
    # Source the p10k configuration if it exists
    [[ -f "$P10K_CONFIG" ]] && source "$P10K_CONFIG"

    # Source the powerlevel10k theme if it exists
    [[ -f "$POWERLEVEL10K_THEME" ]] && source "$POWERLEVEL10K_THEME"
fi
