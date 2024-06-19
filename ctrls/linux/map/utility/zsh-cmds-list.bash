##########===========----------------
# Enhanced ls with LSDeluxe
##########===========----------------
alias lsc='lsd' # lsd is a ls command with colorful output, file type icons, and more - https://github.com/lsd-rs/lsd

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
