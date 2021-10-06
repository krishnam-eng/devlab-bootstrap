##########===========----------------
# enhanced ls with built-in
##########===========----------------

# Dot: Showing All Hidden (Dot) Files in the Current Directory
# add -l for long list
alias l.='ls -d .*'

# All: long list,show almost all,show type,human readable (with dot files)
# alias la="ls -lABXFh --block-size=K" # ubuntu
alias la="ls -lABFh" # mac

# Recursive: sorted by date,recursive,show type,human readable
alias lr='ls -tRFh'

# Tree: use tree like ls , -a => all , -prune => no empty dir , -L 2 => 2 level
alias lt="tree "
alias lt1="tree -L 1"
alias lt2="tree -L 2"
alias lt3="tree -L 3"
alias lt4="tree -L 4"

# Order: with Size and Sorted
alias lo='ls -1FSsh'

# ls for machince read (all files and full timestamp
alias lm="ls -aFXZ --full-time  --sort=size --block-size=KiB -n"

########## List <Context> ##################
# list all process in tree
alias lsps="pstree -p"

# List all env
alias lsenv="declare -p" # or use 'export -p' or 'env' to see all exported variables

# List all variables
alias lsvar="set"

# List all gh
alias lsgh="lt1 ~/github/"

# List node installed packages
alias lsnd="lt1 ~/kroot/node/bin"

# List all my dir
alias lsmy="lt1 ~/.my*"

# list shells & you can change shell chsh -s /path
alias lssh="cat /etc/shells"

# Other useful options
# -1 => print in one column

##########===========----------------
# enhanced ls with exa
##########===========----------------

alias els="exa"

alias eld="exa -ld .*"

alias ela="exa --long"

alias elo="exa -l --header -s"

alias elr="exa --recurse"

alias elg="exa --long --header --git"

alias elm="exa --long --extended"

alias elt="exa --tree --long"

alias elt1="exa --tree --long --level=2"
alias elt2="exa --tree --level=2 --long"
alias elt3="exa --tree --level=3 --long"
alias elt4="exa --tree --level=4 --long"
