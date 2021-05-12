alias tns='tmux -f ~tmux/.tmux.conf new-session -s'

alias tls='tmux list-sessions'

alias ta='tmux attach -t'
alias tad='tmux attach -d -t'

alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'


tds (){
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

  zsh ~tmux/sessions/create_ghproj_workspace.zsh $session $repo_path
}
