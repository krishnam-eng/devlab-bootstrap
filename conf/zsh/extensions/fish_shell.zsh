#!/usr/bin/env zsh

# Prerequisites: git clone zsh-syntax-highlighting, zsh-autosuggestions

# Enable syntax highlighting like fish-shell - make it easy to spot syntax and fix syntax before executing
[[ ! -f $HOME/Paradigm/Development/Extensions/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] || source $HOME/Paradigm/Development/Extensions/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Implementation of the Fish-like fast/unobtrusive autosuggestions for zsh from history
[[ ! -f $HOME/Paradigm/Development/Extensions/zsh-autosuggestions/zsh-autosuggestions.zsh ]] || source $HOME/Paradigm/Development/Extensions/zsh-autosuggestions/zsh-autosuggestions.zsh

# Implementation of the Fish shell's history search feature, where you can type in any part of any command from history and then press chosen keys, such as the UP and DOWN arrows, to cycle through matches.
if [[ -f $HOME/Paradigm/Development/Extensions/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
	source $HOME/Paradigm/Development/Extensions/zsh-history-substring-search/zsh-history-substring-search.zsh
	# enable key binding for up and down
	bindkey "$terminfo[kcuu1]" history-substring-search-up
	bindkey "$terminfo[kcud1]" history-substring-search-down
fi