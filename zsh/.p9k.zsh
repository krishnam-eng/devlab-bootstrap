# Customise the Powerlevel9k prompts
# https://github.com/Powerlevel9k/powerlevel9k#prompt-customization
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
 #ssh
  context
  dir_writable
  vcs
  newline
)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status
  command_execution_time
  background_jobs
  virtualenv
  pyenv
  aws
  dir
 #history
 #time
)

# Add an empty line before each prompt.
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
    
# default is 3
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=5

# default 2
POWERLEVEL9K_SHORTEN_DIR_LENGTH=5

POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique

POWERLEVEL9K_MODE=powerline

POWERLEVEL9K_HOST_ICON="\uF109 "
POWERLEVEL9K_SSH_ICON="\uF489 "
