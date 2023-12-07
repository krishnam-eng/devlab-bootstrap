##########===========----------------
# Custom commands for listing
#
#  Utilizes getent to get entries in a number of important text files called databases
##########===========----------------
alias lssh="cat /etc/shells"
alias lsgrp="getent group | cut -d: -f1" # list all groups
alias lsusr="getent passwd | cut -d: -f1" # list all users
alias lsgrpusr="getent group" # get group users

##########===========----------------
# ls commands
# f- full path
##########===========----------------

# Dot: Showing All Hidden (Dot) Files in the Current Director. add -l for long list

alias ld='ls -d .*'
alias ldf='ld "$(pwd)"/*'

# All: long list,show almost all,show type,human readable (with dot files)
# alias la="ls -lABXFh --block-size=K" # debian
alias ll="ls -lFh" # all dir w/o dot dir  - Long List
alias lA="ls -lAFh" # all dir w/ dot dir  - List All
alias la="ls -lAFh" # duplicate alias for convenience
alias laf='la "$(pwd)"/*' # all dir w/ dot dir  - List All

# Recursive: sorted by date,recursive,show type,human readable
alias lR='ls -tRFh'

# Order: with Size and Sorted
alias los='ls -lFaSh'

# Order: with time and Sorted
alias lot='ls -lart'

# ls for machince read (all files and full timestamp
alias lm="ls -aFXZ --full-time  --sort=size --block-size=KiB -n"

##########===========----------------
# tree commands
##########===========----------------
# Tree: use tree like ls , -a => all , -prune => no empty dir , -L 2 => 2 level
alias lt="tree -L 1"
alias lt1="tree -L 1"
alias lt2="tree -L 2"
alias lt3="tree -L 3"
alias lt4="tree -L 4"
alias lt5="tree -L 5"
alias lt6="tree -L 6"
alias lt7="tree -L 7"
alias lt8="tree -L 8"
alias lt9="tree -L 9"
alias ltA="tree"

