# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -f ~/hrt/ext/powerlevel10k/powerlevel10k.zsh-theme ]]; then
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

##############
#  Auto Completion & Some More Magic (File Navigation)
##############
# Load auto completion feature
autoload -Uz compinit
compinit -u # https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories

# Enable auto complete for kubectl
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
 # make completion work with kubecolor
 compdef kubecolor=kubectl
fi

# Enable auto complete for helm
if [ $commands[helm] ]; then
  source <(helm completion zsh)
fi

# Change dir by just hitting enter on dir name
setopt autocd

################
# Working with History
#   make myshell remember like elephant
################
HISTFILE=$HOME/hrt/states/shell/.zhistfile # up or down to navigate history or use CTR+R to search history
HISTSIZE=1000000
SAVEHIST=1000000 # hist won't be _saved_ with out this conf

# saves timestamp and duration for each history entry run. excellent for data analysis
setopt EXTENDED_HISTORY

# If a new command line being added to the history list duplicates an older one, the older command is removed from the list
setopt HIST_IGNORE_ALL_DUPS

# add entries to the history as they are typed instead of waiting shell to exit. I know you want this.
setopt INC_APPEND_HISTORY

# reduce extra spaces and tabs from history entries
setopt HIST_REDUCE_BLANKS

# share history between different zsh processes
setopt SHARE_HISTORY

############
# FISH Shell Features
############

# Order of syntax highlighter should be before history search
# Enable syntax highlighting like fish-shell - make it easy to spot syntax and fix syntax before executing
[[ ! -f ~/hrt/ext/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] || source ~/hrt/ext/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable the Fish-like fast/unobtrusive autosuggestions for zsh from history
[[ ! -f ~/hrt/ext/zsh-autosuggestions/zsh-autosuggestions.zsh ]] || source ~/hrt/ext/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable the Fish shell's history search feature, where you can type in any part of any command from history and then press chosen keys, such as the UP and DOWN arrows, to cycle through matches.
if [[ -f ~/hrt/ext/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  source ~/hrt/ext/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
fi

# Lean and powerful prompt
if [[ -f ~/hrt/ext/powerlevel10k/powerlevel10k.zsh-theme ]]; then
  unset ZSH_AUTOSUGGEST_USE_ASYNC
  source ~/hrt/ext/powerlevel10k/powerlevel10k.zsh-theme
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi
