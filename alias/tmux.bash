# creat new-session
alias tmcns='tmux -f ~tmux/.tmux.conf new-session -s'

alias tmls='tmux list-sessions'

alias tmah='tmux attach -t'
alias tmad='tmux attach -d -t'

alias tmksr='tmux kill-server'
alias tmksn='tmux kill-session -t'

# tmux create default-session
tmcds (){
  if [ $# -eq 0 ]
  then
    session="df_$(date +%Y%m)" # refersh default session monthly once at max
    repo_path="$HOME/github"
  else
    session=$1
    repo_path="~${1}rp" # use session name same as project abbrev
  fi

  echo "${LOG_TS}Session Name: ${session}"
  echo "${LOG_TS}Repo Path: ${repo_path}"

  cd `printf "%s/%s" $(dirname ~pfkrp) $(basename ~pfkrp)`

  zsh ~tmux/sessions/create_ghproj_workspace.zsh $session $repo_path
}

alias tmalias="alias | awk '/^tm/{print}' | lolcat "
