# Check if the system is either Linux or Darwin (macOS)
if [ "$(uname)" = "Linux" ] || [ "$(uname)" = "Darwin" ]; then
  # Define the base directory
  base_dir="$HOME/Paradigm/Development/Root/conf/zsh/rc.d"

  # Log the start of sourcing process
  ## echo "Starting to source .zshrc files from $base_dir"

  # Record the start time
  ## start_time=$(date +%s)

  # Source all .zshrc files in the specified directories
  for dir in shell tools; do
    for efile in "$base_dir/$dir"/*.zshrc; do
      if [ -r "$efile" ]; then
        source "$efile"
        ## echo "Sourced: $efile"
      else
        ## echo "Skipped unreadable file: $efile"
      fi
    done
  done

  # Record the end time
  ## end_time=$(date +%s)

  # Calculate the duration
  ## duration=$((end_time - start_time))

  # Log the end of sourcing process and duration
  ## echo "Finished sourcing .zshrc files in $duration seconds"

  # Unset variables to clean up the environment
  unset base_dir dir efile start_time end_time duration
fi
