#   mkdir -p $HOME/hrt/ext
#
#   # order matters
#   git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions  $HOME/hrt/ext/zsh-autosuggestions
#   git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search  $HOME/hrt/ext/zsh-history-substring-search
#   git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting $HOME/hrt/ext/zsh-syntax-highlighting
#
#   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/hrt/ext/powerlevel10k
#   echo 'source $HOME/hrt/ext/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
#   p10k configure # it wraps the zshrc config with p10k config

# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable syntax highlighting like fish-shell - make it easy to spot syntax and fix syntax before executing
[[ ! -f ~/hrt/ext/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] || source ~/hrt/ext/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Implementation of the Fish-like fast/unobtrusive autosuggestions for zsh from history
[[ ! -f ~/hrt/ext/zsh-autosuggestions/zsh-autosuggestions.zsh ]] || source ~/hrt/ext/zsh-autosuggestions/zsh-autosuggestions.zsh

# Implementation of the Fish shell's history search feature, where you can type in any part of any command from history and then press chosen keys, such as the UP and DOWN arrows, to cycle through matches.
if [[ -f ~/hrt/ext/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source ~/hrt/ext/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

unset ZSH_AUTOSUGGEST_USE_ASYNC

source ~/hrt/ext/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh