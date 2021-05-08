##################
# Named Dirctory
#
# What: Creating Named Dir by adding ~shortcutname entry in "fil/dir names hash table."
#
# Why: named dir can be called like ~shortcutname  similar to how ~ refers to home dir
#
# named directory or user are refered with ~ prefix
###################

# quick access to config files
hash -d zsh=~/.myzsh      # ~zsh
hash -d bash=~/.mybash    # ~bash
hash -d tmux=~/.mytmux    # ~tmux
hash -d nano=~/.mynano    # ~nano
hash -d venv=~/.myvenv    # ~venv

# quick access to Repos
hash -d gh=~/github                     # ~gh
hash -d lrp=~/github/ohmy-linux         # workspace repo ~lrp
hash -d alias=~/github/ohmy-linux/alias # ~alias
hash -d env=~/github/ohmy-linux/env     # ~env

hash -d hltrp=~/github/howdoi-loadtest   # load testing ~hltrp
hash -d pprp=~/github/practice-python   # python repo ~pprp
