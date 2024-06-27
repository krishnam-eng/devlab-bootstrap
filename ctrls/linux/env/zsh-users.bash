# more at https://github.com/zsh-users/zsh-autosuggestions
# Highlight style for the suggestion
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5fafff"

# Strategy to use for autosuggestions. Can be either 'history' to only use history
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
#    By default ZSH_HIGHLIGHT_HIGHLIGHTERS is (main)
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp cursor root line)


# TODO: Play with highlighters to get the contrast right
#  https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
