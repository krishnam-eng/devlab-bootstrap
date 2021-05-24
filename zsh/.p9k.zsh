# Customise the Powerlevel9k prompts
# https://github.com/Powerlevel9k/powerlevel9k#prompt-customization
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  ssh
  dir
  dir_writable
  vcs
  newline
)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status
  command_execution_time
  background_jobs
  virtualenv
  history
  time
)
