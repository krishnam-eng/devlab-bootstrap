# Usage:
#         repeatN <times> <interval> <command>  => repeat <times> times
#        repeatN -1 <interval> <command>             => repeat forever
function repeatN() {
    local times=$1
    local interval=$2
    local command_to_run="${@:3}"

	echo $command_to_run

    if (( times == -1 )); then
        i = 1;
        while true; do
            echo "Iteration $i"

            # Run the specified command
            eval "$command_to_run"

            # Sleep for the specified interval
            sleep "$interval"
            i++;
        done
    else
        for ((i = 1; i <= times; i++)); do
            echo "Iteration $i"

            # Run the specified command
            eval "$command_to_run"

            # Sleep for the specified interval
            sleep "$interval"
        done
    fi
}

curld() {
  local directory=$1

  # Check if the directory exists
  if [ ! -d "$directory" ]; then
    echo "Error: Directory $directory not found."
    return 1
  fi

  # Iterate through files in the directory, assuming they are named like "01_command.txt", "02_command.txt", etc.
  for file in "$directory"/*.sh; do
    if [ -f "$file" ]; then
      echo "Executing: curl $(cat "$file")"
      sh "$file"
      echo "----------------------------------------"
    fi
  done
}