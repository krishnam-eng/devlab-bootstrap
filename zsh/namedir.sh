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
hash -d nano=~/.mynano    # ~nano
hash -d tmux=~/.mytmux    # ~tmux
hash -d bash=~/.mybash    # ~bash


# quick access to repos
hash -d gh=~/github               # ~gh
hash -d wsrepo=~/github/ohmy-linux # workspace repo ~wsrepo
hash -d pyrepo=~/github/practice-python # python repo ~pyrepo
hash -d learnpy=~/github/practice-python/ex-files/learning-python # ~learnpy

