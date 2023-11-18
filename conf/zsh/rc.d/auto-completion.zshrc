##############
#  Auto Completion & Some More Magic (File Navigation)
#
#     Tab to start the auto-complete, tab-again to cycle-through
#
#   types:
#       filname/dir      [ str<Tab>
#       external command [ str<Tab>
#       built-in command [ str<Tab>
#       command option   [ -<Tab>
#       env variables    [ $str<Tab>
#       alias            [ str<Tab>
#       function         [ str<Tab>
#       expanding cmd    [ echo `which zsh`<Tab> => echo /usr/bin/zsh
#       kill             [ menu to select process id
#
#   you can see where this is going
#
##############
# echo 'Auto Completion & Some More Magic Setup...'

# Load the completion script placed in ...
fpath=($HOME/hrt/boot/conf/custom/linux/console $fpath)

# git clone https://github.com/zsh-users/zsh-completions.git
# fpath=(~/hrt/ext/zsh-completions/src $fpath)
# Note: Selectively copied the required files under consoles dir

# function load is not compatible with npm file
source $HOME/hrt/boot/custom/linux/console/npm-completion.zshrc

# Load auto completion feature
autoload -Uz compinit
compinit -u # https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories

# Enable auto complete for kubectl
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
 # make completion work with kubecolor
 compdef kubecolor=kubectl
fi

# Enable auto complete for helm
if [ $commands[helm] ]; then
  source <(helm completion zsh)
fi

# To run command completion, you need to run bashcompinit by adding the following autoload line
autoload bashcompinit && bashcompinit

# Enable auto complete for aws cli
if [ $commands[aws] ]; then
  complete -C '/usr/local/bin/aws_completer' aws
fi

# By default, the completion doesn't allow option-stacking, meaning if you try to complete docker run -it <TAB>
# it won't work, because you're stacking the -i and -t options.
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# add more flair to your auto complete sugesstions, by grouping them by type
zstyle ':completion:*' group-name ''

# enable menu selection from the guess list
zstyle ':completion:*' menu select=1

# show command options with description and make it easy to move around too with double Tab
zstyle ':completion:*' verbose yes

# Change dir by just hitting enter on dir name
setopt autocd

# Move cursor inbetween incomplete word and type
setopt completeinword

# Suggest mis-spelled commands
setopt correct

# type cmd and pressing spacebar now triggers history expansion. e.g. echo !!<Space> => echo ls
bindkey ' ' magic-space
