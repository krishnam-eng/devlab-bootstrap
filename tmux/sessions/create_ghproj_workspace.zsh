#!/usr/bin/env zsh

session=$1
repo_path=$2

tmux has-session -t $session 2>/dev/null
if [ $? != 0 ]
then
  ### New session with first window
	tmux new-session -s $session -n work -d  #todo: -c doesn't seems to be setting ct dir and affected -c option in window split also. so, using cd directly

	# execute pane and open with current dir of prev pane
  tmux send-keys -t $session:1.1 "cd $repo_path" C-m
  sleep 1 # to make the cd run first before split so that ct pane will be copied properly
  tmux send-keys -t $session:1.1 "avenv $1" C-m
	tmux split-window -v -p 35 -t $session:1  -c "#{pane_current_path}"
	tmux split-window -h  -t $session -c "#{pane_current_path}"
  tmux send-keys -t $session:1.2 "gst" C-m
	tmux send-keys -t $session:1.3 "vscode $repo_path &" C-m

  # Window "AdHoc"
  tmux new-window -n adhoc -t $session
  tmux split-window -fv -t $session:2 -c "#{pane_current_path}"
  tmux split-window -fh -t $session:2 -c "#{pane_current_path}"
  tmux select-pane -t $session:2.1

  # Window "Build Functions"
  tmux new-window -n func -t $session
  tmux send-keys -t $session:3.1 "cd ~func; lt1 | lolcat" C-m
  tmux split-window -h -t $session:3 -c "#{pane_current_path}"
  tmux select-pane -t $session:3.1

  # Window "Create Dev Env"
 	tmux new-window -n denv -t $session
	tmux send-keys -t $session:4.1 "cd ~env; lt1 | lolcat" C-m
	tmux split-window -h -t $session:4
	tmux send-keys -t $session:4.2 "cd ~alias; lt1 | lolcat" C-m

  # Window system
	tmux new-window -n sys -t $session
	tmux select-layout -t $session:5.1 even-vertical
	tmux send-keys -t $session:5.1 "htop"	C-m #glances

	tmux new-window -n disk -t $session
	tmux send-keys -t $session:6.1 "cd ~/; ncdu" C-m

	# Window "console"
  tmux select-window -t $session:1
  tmux select-pane -t $session:1.1
fi

# If -d is specified, any other clients attached to the session are detached. -c working-directory
tmux attach-session -t $session

echo "${LOG_TS} Session ${session} is created"
