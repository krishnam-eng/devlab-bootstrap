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

wait_until() {
  local max_wait_time=${1:-60}  # Default to 60 seconds
  local wait_interval=${2:-5}  # Default to 5 seconds
  local condition="$3"

  # Initialize the total wait time to 0
  local total_wait_time=0

  # Loop until the condition is met or the maximum wait time is exceeded
  for ((i=1; i<=$max_wait_time; i+=$wait_interval)); do
    # Check the condition
    if eval "$condition"; then
      tlog $DEBUG "It is up !"
      return 0  # Success
    else
      # Increment the total wait time and print the accumulated waiting time
      total_wait_time=$((total_wait_time + wait_interval))
      tlog $DEBUG "Waiting..."
      sleep $wait_interval
      tlog $TRACE "Total wait time: $total_wait_time seconds"
    fi
  done

  tlog $FATAL "Maximum wait time exceeded"
  return 1  # Failure
}

