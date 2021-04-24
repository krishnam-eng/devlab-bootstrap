######
# Enhance existing commands and builtins 
#   
#   by setting default preferable options
#
###### 

# creat missing dirs in the path
alias mkdir="mkdir -p"

# reload default shell run commands
alias src="source ~/.zshrc"

# use default edit as nano & frquent edit files
alias e="nano"
alias ezshrc="nano ~/.zshrc"

#####################
#### ls, the common ones I use a lot shortened for rapid fire usage
#####################

# ls - set color option 
alias ls="ls --color=always --width=80"

# with Size and Sorted
alias lS='ls -1FSsh'

# long list : size,show type,human readable (with out dot files)
alias ll='ls -lFh'     

# Dot: Showing All Hidden (Dot) Files in the Current Directory
alias ldot='ls -ld .*'

# All: long list,show almost all,show type,human readable (with dot files)
alias la="ls -ABFXh --block-size=K -l"                                                     

# all file but in one col 
alias lA='ls -1Fcart'

# ls for machince read (all files and full timestamp
alias lm="ls -aFXZ --full-time  --sort=size --block-size=KiB -n"                          

# Recursive: sorted by date,recursive,show type,human readable
alias lr='ls -tRFh'   

# Tree: use tree like ls , -a => all , -prune => no empty dir , -L 2 => 2 level                          
alias lt="tree -a -L 1"
alias lt1="tree -a -L 1"
alias lt2="tree -a -L 2"
alias lt3="tree -a -L 3"
alias lt4="tree -a -L 4"
alias lt5="tree -a -L 5"

# list shells & you can change shell chsh -s /path
alias lshells="cat /etc/shells"



# Quick access to the .zshrc file
alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc' 

# set color to grep
alias grep='grep --color'

# smart grep with default exclution filter
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git} '

alias t='tail -f'

# clear dump files using cmd substitution
# The earlier shell syntax was to use backquotes (``) instead of $() for enclosing the sub-command. The $() syntax is preferred over the older `` syntax because it is easier to nest and arguably easier to read
alias cdump="rm $(find . -name "*dump")"
alias sdump='find . -name "*dump"'

# list 

#alias dud='du -d 1 -h'
#alias duf='du -sh *'

#alias ff='find . -type f -name'

#alias h='history'
#alias hgrep="fc -El 0 | grep"
#alias help='man'
#alias p='ps -f'
#alias sortnr='sort -n -r'
#alias unexport='unset'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

#########################
# Replacing Builtins and External Commands
#
# enable -a will list all builtins and their enabled or disabled status.
########################

cd () {
    builtin cd "$@"
    echo "${cs_yellow}$OLDPWD${cs_reset} --> ${cs_bblue}$PWD${cs_reset}"
}

#######################
## Func
#######################

# Determining if You Are Running Interactively
# $- is a string listing of all the current shell option flags 
# is_interactive ; echo $!
is_interactive(){
    case "$-" in
        *i*) return 1;;
        *) return 0;;
    esac
}
