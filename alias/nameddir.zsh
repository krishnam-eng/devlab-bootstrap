##################
# Named Dirctory
#
# What: Creating Named Dir by adding ~shortcutname entry in "fil/dir names hash table."
#
# Why: named dir can be called like ~shortcutname  similar to how ~ refers to home dir
#
# named directory or user are refered with ~ prefix
###################

# quick access to config files or custom setting
hash -d zsh=~/.myzsh      # ~zsh
hash -d bash=~/.mybash    # ~bash
hash -d tmux=~/.mytmux    # ~tmux
hash -d nano=~/.mynano    # ~nano
hash -d venv=~/.myvenv    # ~venv
hash -d func=~/.myfunc    # ~func
hash -d alias=~/.myalias  # ~alias
hash -d env=~/.myenv      # ~env

hash -d gh=~/github       # ~gh

# quick access to all checkout repos
# convention "1stword-1stchar"+"2ndword-1stchar"+"2ndword-lastchar")
hash -d olxrp=~/github/ohmy-linux        # workspace repo ~lrp
hash -d hltrp=~/github/howdoi-loadtest   # load testing ~hltrp
hash -d ppnrp=~/github/practice-python   # python repo ~pprp
