#!/usr/bin/bash

tmux has-session -t proj-linuxenv
if [ $?!=0 ]
then
	tmux new-session -s proj-linuxenv -n editor -d

	tmux send-keys -t proj-linuxenv 'cd ~/ghrepo/oh-my-linux-env' C-m
	tmux send-keys -t proj-linuxenv 'nano tmux/.tmux.conf' C-m

	tmux split-window -v -p 20 -t proj-linuxenv

	tmux send-keys -t proj-linuxenv:1.2 'cd ~/ghrepo/oh-my-linux-env' C-m
	tmux send-keys -t proj-linuxenv:1.2 'git status' C-m

	tmux split-window -h -p 20 -t proj-linuxenv

	tmux send-keys -t proj-linuxenv:1.3 'top' C-m

	tmux new-window -n reference -t proj-linuxenv

	tmux split-window -h -t proj-linuxenv:2
	tmux send-keys -t proj-linuxenv:2.1 'nano ~/ghrepo/oh-my-linux-env/zsh/.zshrc' C-m
	tmux send-keys -t proj-linuxenv:2.1 'nano ~/ghrepo/oh-my-linux-env/alias/.alias' C-m
	tmux select-pane -t proj-linuxenv:2.1

	tmux select-window -t proj-linuxenv:1
fi

tmux attach -t proj-linuxenv
