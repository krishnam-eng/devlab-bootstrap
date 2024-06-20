################
# Working with History
#   make myshell remember like elephant
#
#
#  Previous Command
#     **Event Designator(!) + Word Designators(*, ^, $ - like regex style)**
#       !! -> previously run command (e.g, if sudo is missed, instead retying all, use `sudo !!`)
#       !* -> All Args of the prev. cmd (e.g, `ls /var/zxv.f ; stat !*`)
#       !^ -> First Arg of the prev. cmd (e.g, `ls /var/zxv.f xyx.txt ; stat !^`)
#       !$ -> Last Arg of the prev. cmd (e.g, `ls /var/zxv.f xyx.txt ; stat !$`)
#
#  Search History
#     !<hist.number> -> n th cmd in hist use '-' to count backward
#     !<match.str> -> last cmd executed which had this 'str'
#
#  Substitution
#     ^history-entry^word-replacement
################
# echo 'History Configuration...'

HISTFILE=$HOME/Paradigm/Development/States/.zhistfile # up or down to navigate history or use CTR+R to search history
HISTSIZE=1000000 # 1M
SAVEHIST=1000000 # hist won't be _saved_ with out this conf

# To save unexecuted cmd to history, make the command as comment by prefixing # and executing
setopt interactivecomments

# set histchars='@^#' if you want to change default char '!'

# to avoid blind faith during history expansion, Don't execute immediately upon history expansion.
setopt HIST_VERIFY

# saves timestamp and duration for each history entry run. excellent for data analysis
setopt EXTENDED_HISTORY

# If a new command line being added to the history list duplicates an older one, the older command is removed from the list
setopt HIST_IGNORE_ALL_DUPS

# When searching for history entries in the line editor, do not display duplicates of a line previously found, even if the duplicates are not contiguous.
setopt HIST_FIND_NO_DUPS

# reduce extra spaces and tabs from history entries
setopt HIST_REDUCE_BLANKS

# add entries to the history as they are typed instead of waiting shell to exit. I know you want this.
setopt INC_APPEND_HISTORY

# share history between different zsh processes
setopt SHARE_HISTORY