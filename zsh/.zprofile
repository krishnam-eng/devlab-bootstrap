#!/usr/bin/env zsh

[ -z "$TMUX" ] && export TERM=xterm-256color

if [ -d ~/.myenv ]; then
  # Recipe: Running All Scripts in a Directory
  for efile in ~/.myenv/*sh
  do
    source $efile
  done
  unset efile
fi

# use this for log prefix
export LOG_TS="${CS_byellow}[${CS_yellow}$(date --utc --rfc-3339=ns)${CS_byellow}] ${CS_reset}"

