#########
#     Shell Level Actions
#########

# Quick access to the .zshrc file
alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc'

# Load zsh rc
alias zshl="exec zsh -l"

#########
#     Directory Level Actions
#########

# make dir and create the intermediate parent directories if needed
alias mkd="mkdir -p"

# remove "d"ir
alias rmd="\rm -rf"

# copy "d"ir recursively with verbose mode
alias cpd="cp -rv"

# copy current dir name
alias cpname=" echo $PWD | pbcopy"

# navigate dir - go up one to five steps
alias u.="cd .."
alias u..="cd ../.."
alias u...="cd ../../.."
alias u....="cd ../../../.."
alias u.....="cd ../../../../.."
alias u1="cd .."
alias u2="cd ../.."
alias u3="cd ../../.."
alias u4="cd ../../../.."
alias u5="cd ../../../../.."


#########
#      Network / IO
#########
alias ipe='curl ipinfo.io/ip'      # IP External
alias ipi='ipconfig getifaddr en0' # IP Internal - local

########
#     Misc
########
alias hA='history 1' # show all history starting index 1
alias hs='history | grep'
alias hsi='history | grep -i'

alias utc='date -u'

#######
#    Others
#######

# copy after dereferencing "l"inks
alias cpl="cp -L"

# smart grep with default exclution filter
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git} '

alias tf='tail -f'

alias sdump='find . -name "*dump"'