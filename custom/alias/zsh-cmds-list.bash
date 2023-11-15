##########===========----------------
# enhanced ls with exa
##########===========----------------
alias ils='lsd'

alias els="exa"

alias eld="exa -ld .*"

alias ela="exa --long"

alias elo="exa -l --header -s"

alias elr="exa --recurse"

alias elg="exa --long --header --git"

alias elm="exa --long --extended"

alias elt="exa --tree --level=1 --long"
alias elt1="exa --tree --level=1 --long"
alias elt2="exa --tree --level=2 --long"
alias elt3="exa --tree --level=3 --long"
alias elt4="exa --tree --level=4 --long"
alias elt5="exa --tree --level=4 --long"
alias eltA="exa --tree --long"

# Other useful options
# -1 => print in one column

########## List <Context> ##################
# List all env
alias lsenv="declare -p" # or use 'export -p' or 'env' to see all exported variables

# List all variables
alias lsvar="set"

# list all process in tree
alias lsps="pstree -p"

# List all gh
alias lsgh="lt1 ~/github/"

# List node installed packages
alias lsnd="lt1 ~/hrt/node/bin"

# List all hrt dir
alias lshrt="lt1 ~/hrt"

# list shells & you can change shell chsh -s /path
alias lssh="cat /etc/shells"

#################### better for view / copy 

# removes number from history display
alias lhist="history | awk '{ \$1=\"\"; print \$0 }'"
