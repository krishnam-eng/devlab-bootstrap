# Usage: repeat 5 "echo Hello, World!"
# Runs the specified command every 5 seconds
function refresh() {
  local interval=$1
  local command_to_run="${@:2}"

  while true; do
    # Run the specified command
    eval "$command_to_run"

    # Sleep for the specified interval
    sleep "$interval"
  done
}``