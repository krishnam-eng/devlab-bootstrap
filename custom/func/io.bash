# Let the user make a choice about something and execute code based on the answer
#
# Called like: choose <default (y or n)> <prompt> <yes action> <no action>
# e.g. choose "y" "Do you want to play a game?" /usr/games/GlobalThermonuclearWar 'printf "%b" "See you later Professor Falkin.\n"'

function choose {
    local default="$1"
    local prompt="$2"
    local choice_yes="$3"
    local choice_no="$4"
    local answer

    read -p "$prompt" answer
    [ -z "$answer" ] && answer="$default"

    case "$answer" in
        [yY1] ) eval "$choice_yes";;
        [nN0] ) eval "$choice_no";;
        * ) printf "%b" "Unexpected answer '$answer'!";;
    esac
}

# Let the user make a choice about something and return a standardized
# answer. How the default is handled and what happens next is up to
# the if/then after the choice in main.
# Called like: choice <prompt>
# e.g. choice "Do you want to play a game?"
# Returns: global variable CHOICE

function choice {
    CHOICE=''
    local prompt="$*"
    local answer
    read -p "$prompt" answer
    case "$answer" in
        [yY1] ) CHOICE='y';;
        [nN0] ) CHOICE='n';;
        * ) CHOICE="$answer";;
    esac
}

# Usage Example:
# choice "Do you want to look at the error logfile? [Y/n]: "
# if [ "$CHOICE" != "n" ]; then
# less error.log
# fi

