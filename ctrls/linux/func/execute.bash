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