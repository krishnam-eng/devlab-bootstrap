#!/usr/bin/env zsh
# Check if the power theme is enabled
if [[ -f "$HOME/Paradigm/Development/Flags/enablepowertheme" ]]; then
    # Source the p10k configuration if it exists
    [[ -f "$HOME/Paradigm/Development/Root/conf/zsh/extensions/.p10k.zsh" ]] && source "$HOME/Paradigm/Development/Root/conf/zsh/extensions/.p10k.zsh"

    # Source the powerlevel10k theme if it exists
    [[ -f "$HOME/Paradigm/Development/Extensions/powerlevel10k/powerlevel10k.zsh-theme" ]] && source "$HOME/Paradigm/Development/Extensions/powerlevel10k/powerlevel10k.zsh-theme"
fi
