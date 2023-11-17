# use this for testing templates that can be used part of other functions

confirm_action() {
  while true; do
      echo -n "$1 (y/n): "
      stty -echo
      read -r response
      stty echo
      echo
      case "$response" in
          [yY][eE][sS]|[yY])
              # Add your action code here
              echo "Performing action..."
              # Your code goes here
              break
              ;;
          [nN][oO]|[nN])
              echo "Action canceled."
              break
              ;;
          *)
              echo "Invalid input. Please enter 'y' or 'n'."
              ;;
      esac
  done
}

function take_all_as_option() {
  if [[ "$1" == "-A" || "$1" == "-all" ]]; then
    echo "Input: $1"
    echo "Performing action for all..."
    # Add your code here to handle the -A or -all input
  else
    echo "Invalid input. Please provide -A or -all."
  fi
}