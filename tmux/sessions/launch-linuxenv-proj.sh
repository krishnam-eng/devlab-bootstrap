#!/usr/bin/bash

session="proj-linux";

tmux has-session -t $session

if [$?!=0]; then
	tmux new-session -s $session -n editor -d

	tmux send-keys -t $session 'cd ~/ghrepo/oh-my-linux-env' C-m
	tmux send-keys -t $session 'nano tmux/.tmux.conf' C-m

	tmux split-window -v -p 20 -t $session

	tmux send-keys -t $session:1.2 'cd ~/ghrepo/oh-my-linux-env' C-m
	tmux send-keys -t $session:1.2 'git status' C-m

	tmux split-window -h -p 20 -t $session

	tmux send-keys -t $session:1.3 'top' C-m

	tmux new-window -n config -t $session
	tmux send-keys -t $session:2.1 'nano ~/ghrepo/oh-my-linux-env/zsh/.zshrc' 

	tmux split-window -h -t $session:2
	tmux send-keys -t $session:2.2 'nano ~/ghrepo/oh-my-linux-env/alias/.alias' C-m
	tmux select-pane -t 1

	tmux new-window -n manual -t $session
	tmux send-keys -t $session:3.1 'man tmux' C-m
	tmux split-window -h -t $session:3
	tmux select-pane -t 1

	tmux select-window -t $session:1
	tmux select-pane -t 1
fi

tmux attach-session -t $session
