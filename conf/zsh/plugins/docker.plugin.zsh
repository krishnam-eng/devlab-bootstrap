# Support Compose v2 as docker CLI plugin
# This tests that the (old) docker-compose command is in $PATH and that
# it resolves to an existing executable file if it's a symlink.
[[ -x "${commands[docker-compose]:A}" ]] && dccmd='docker-compose' || dccmd='docker compose'

alias dcmp="$dccmd"

unset dccmd
