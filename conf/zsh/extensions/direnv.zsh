# direnv is an extension for your shell. It augments existing shells
# with a new feature that can load and unload environment variables
# depending on the current directory.
#
# https://github.com/direnv/direnv
#
#   Before each prompt, direnv checks for the existence of a .envrc file (and optionally a .env file)
#   in the current and parent directories. If the file exists (and is authorized),
#   it is loaded into a bash sub-shell and all exported variables are then captured by direnv and then
#   made available to the current shell.
eval "$(direnv hook zsh)"