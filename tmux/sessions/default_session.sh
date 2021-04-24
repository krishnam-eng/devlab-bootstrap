#!/usr/bin/env bash

session="default_$(date +%Y%m)" # refersh session monthly once at max todo: send arg for name prefix

echo "${LOG_TS}Session Name: ${session}"

repo_path="~/github"
echo "${LOG_TS}Repo Path: ${repo_path}"

tmux has-session -t $session 2>/dev/null
if [ $? != 0 ]
then
  ### New session with first window
	tmux new-session -s $session -n work -d

	# execute pane and open with current dir of prev pane
	tmux split-window -v -p 35 -t $session:1  -c "#{pane_current_path}"
	tmux send-keys -t $session:1.2 "cd ${repo_path}; lt1" C-m
	tmux split-window -h  -t $session -c "#{pane_current_path}"

  # Window "Build Functions"
  tmux new-window -n func -t $session
  tmux send-keys -t $session:2.1 "nano ~/.myfunc/basic.bash" C-m
  tmux split-window -h -t $session:2
  tmux send-keys -t $session:2.2 "nano ~/.myfunc/basic.zsh" C-m

  # Window "Create Dev Env"
 	tmux new-window -n denv -t $session
	tmux send-keys -t $session:3.1 "cd ~/.myzsh" C-m
	tmux split-window -h -t $session:3
	tmux send-keys -t $session:3.2 "cd ~/.myalias; lt1 | lolcat" C-m

  # Window system
	tmux new-window -n sys -t $session
	tmux send-keys -t $session:4.1 "htop"	C-m #glances

	tmux new-window -n disk -t $session
	tmux send-keys -t $session:5.1 "cd ~/; ncdu" C-m

	# Window "console"
  tmux select-window -t $session:1
  tmux select-pane -t $session:1.1
fi

# If -d is specified, any other clients attached to the session are detached. -c working-directory
tmux attach-session -t $session

echo "${LOG_TS} Session ${session} is created"
