#!/usr/bin/env zsh
################
#author	      : krishnam
################

function kill_port(){
    # Get the process ID of the process that is using the port
  port=$1
  pids=$(lsof -ti :$port | tr '\n' ' ')

  # Check if the process is running
  if [ -n "$pids" ]; then
    # Kill the process
    tlog $WARN "Killing process with PIDs: $pids"
    if kill $pids; then
      echo "Processes killed successfully."
    else
      echo "Failed to kill processes."
    fi
  else
    tlog $INFO echo "No process found using port $port"
  fi
}
