#####################
#         Redirection & MultiOS
#
####################

# To prevent stdout or stderr (1> or 2>) redirection to existing file, use append >>
setopt noclobber
#o enable multiple output stream
setopt multios

# Building Dir Stack
# pushd ~/mylib &>/dev/null
# pushd /etc &>/dev/null
# pushd /var &>/dev/null
# alias sd="pushd" # switch dir using dir stack
### CLOSE: Dir Nav

### To list the values of ....., run the below
# todo: move to ls.bash file
#  %setopt ; unsetopt -> zsh options
#  %alias
#  %functions ; echo $fpath;
#  %enable ; diable -> bulit-in commands
#  %hash -> named dirs
#  %dirs -> dir stack
#  %echo $- => shows zsh options
#  %echo $PROMPT
###

############
# ZLE
#
#   The Zsh Line Editor allows you to define your own key bindings and set of custom keymaps (collections of key bindings) in addition to extending predefined entries.
#
# From EMACS Keybindings
#
# Move
#   Ctrl + A Moves the cursor to the beginning of the line
#   Ctrl + E Moves the cursor to the end of the line
#
#   Esc + B Moves the cursor backwards one word
#   Esc + F Moves the cursor forward one word
#
# Delete
#   Ctrl + U Deletes the whole line
#   Ctrl + K Kills (or deletes) until the end of the line
#
#   Esc + Backspace Deletes one word on the left of the cursor
#   Esc + D Deletes one word on the right of the cursor
#
#   Ctrl + W Deletes the whole word backwards from the cursor location
#
#   Ctrl + D Deletes a character (moves forward) / lists completions / logs out
#
# Yank
#   Ctrl + Y Yanks the last killed word
#   Esc + Y Switches the last yanked word
#
# Swap
#   Ctrl + T Transposes two characters
#   Esc + T Transposes two words
#
# Search
#   Ctrl + R Incremental search backwards
#   Ctrl + S Incremental search forwards (automatically enables NO_FLOW_CONTROL option)
#   Esc  + < go to very beginning of our history file
#
# Execute Mode
#  Esc + x  - open cmd mode: ctr+shit+p in vscode  or : in tmux
#     where-is mode
#
#  use `bindkey -L` to list all current bindings
#  todo: -L and find useful commands - take a print
#  use `bindkey -l` to view avilable keymaps
# todo: Esc binding in mac !?
##################

# By default zsh relies on $EDITOR & $VISUAL to guess the binding. Don't guess now.(use -v for vi mode

# For Vim-style navigation in the Zsh terminal
bindkey -v

# For emacs-style navigation in the Zsh terminal
# bindkey -e for emacs

# skip beeping on errors.
setopt NO_BEEP