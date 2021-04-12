
#todo: change the working dir to the file path dir 
# make everything else relative path

source ~/github/ohmy-linux/zsh/named_dir.sh
source ~/github/ohmy-linux/alias/tmux.alias

### START: Automation
# Auto completion
autoload -Uz compinit
compinit # Tab to start the auto-complete, tab-again to cycle-through
setopt completeinword # Move cursor inbetween incomplete word and type

# Suggest mis-spelled commands
setopt correct

# Change dir by just hitting enter on dir name
setopt autocd

# Bulk rename utility
autoload -U zmv # e.g zmv '(*)_(*)' 'out_$2.$1', use -n option to do dry-run

# Load my plugins
#source  ~/.z_oh-my-zsh/*.sh
#add one apt-install script - fonts-powerline, java , git 

# Reload run commands/configuration
alias src="source ~/.zshrc"

# Edit configuration (save them in github, explore oh-my-zsh plugins & themes - agnoster)
alias ezenv="nano ~/.zshenv" # Put global changes (for every 'login','i','ni' shell session)
alias ezpro="nano ~/.zprofile" # for only 'login' shells profiles
alias ezrc="nano ~/.zshrc" # Put customization for user-level interactions (for every 'i' shell)
alias ezlog="nano ~/.zlogin" # for only login shell, login comes at the end so admin can override rc

alias enrc="nano ~/.nanorc"
### CLOSE: Automation

### START: Redirection & MultiOS
# To prevent stdout or stderr (1> or 2>) redirection to existing file, use append >>
setopt noclobber
# To enable multiple output stream
setopt multios
### CLOSE: Redirection & MultiOS

### START: Command History
# up or down to navigate history or use CTR+R to search history
HISTFILE=~/.zhistfile
HISTSIZE=1000
SAVEHIST=1000

# To save unexecuted cmd to history, make the command as comment by prefixing # and executing
setopt interactivecomments

# History shortcuts / expansion
alias hist="history"
# !! -> previously run command (e.g, if sudo is missed, instead retying all, use `sudo !!`)
# !* -> Args given to prev. cmd (e.g, `ls /var/zxv.f ; stat !*`)
# !$number -> n'th cmd in hist
# $_ -> Last Arg in the prev.cmd
### CLOSE: Command History

# Building Dir Stack
# pushd ~/mylib &>/dev/null
# pushd /etc &>/dev/null
# pushd /var &>/dev/null
# alias sd="pushd" # switch dir using dir stack
### CLOSE: Dir Nav


### START: List & View alias
#ls for machince read
alias lm="ls -aFXZ --color=always --full-time  --sort=size --block-size=KiB -n"

#ls for human read
alias lh="ls -ABFX --color=always --block-size=K -l"

#ls for normal use
alias ls="ls -ABFX --color=always --width=80"

# use tree like ls , -a => all , -prune => no empty dir , -L 2 => 2 level 
alias lt="tree -a -L 1"
alias lt2="tree -a -L 2"
alias lt3="tree -a -L 3"
alias lt4="tree -a -L 4"
alias lt5="tree -a -L 5"

### CLOSE: List & View alias


### Load alias files
#
#
source ~/.myalias/tmux.alias
###

### Functions
# Listing the prompt colors
function pcolors() {
  for color in {000..255}; do
    print -P "$color: %F{$color}████ Foreground %f%K{$color} Background %k"
  done
}

### To get about the given command or file or dir, run the below
# which
# type
# stat
alias what="whence -w" # -f option will give the function value 
###

###
#PROMPT='%n@%F{green}%m%f %K{red}

### To list the values of ....., run the below
#  %setopt ; unsetopt -> zsh options
#  %alias
#  %functions ; echo $fpath;
#  %enable ; diable -> bulit-in commands
#  %hash -> named dirs
#  %dirs -> dir stack
#  %echo $- => shows zsh options 
#  %echo $PROMPT
###


### Expansions
# 1. Hist Exp
# 2. Alias Exp
# 3. Process Sub => > < >> | , tee
# 4. Param Exp => a=cat ; echo ${a}man => catman
# 5. Cmd Exp => echo ${date}
# 6. Arithmetic Exp  => echo $[4/2] - 2
# 7. Brace Exp => patern into txt e.g %echo c{a,o,u}t => cat cot cut, %echo {1..5} => 1 2 3 4 5,touch
# file_{0..100}
# 8. Filename Exp => path to a file -> ~ , =ls , ~customshortname
# 9. Filename Generation =>  * - any  string , ? - any char , [] any specific chars
###


### Types of Shells
# 1. Login Shell => when you open new terminal
# 2. interactive shell =>  type cmds , login is interatice also
# 3. non-interactive shell => no i/ps taken - run script or cmd %zsh myscript
# echo $- => *i* for interactive
###


### Coloring

# to enable a 256-color terminal. This conditional statement ensures that the TERM variable is only set outside of tmux, since tmux sets its own terminal.
[ -z "$TMUX" ] && export TERM=xterm-256color

# prompt string left & righ

PROMPT='%F{154}%n%f@%F{011}%m%F{010}%#%f '

RPROMPT=' %F{010}[%F{011}%~ %F{154}%*%F{010}]'

# ls & tree: stdout color customization
LS_COLORS='rs=0:fi=0;90:di=01;94:ln=01;96:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*.txt=01;32:*.sh=01;32:ex=00;31:*.bashrc=00;35:*.nanorc=00;35:*.zshrc=00;35:*.profile=00;35:*.pid=0;90:';
export LS_COLORS PROMPT RPROMPT;
### CLOSE: Color Customization for ls & tree
