###
# brew opt-in flags
###

# to install formulae and casks in homebrew/core and homebrew/cask taps using Homebrew’s API instead of needing the (large, slow) local checkouts of these repositories
export HOMEBREW_INSTALL_FROM_API=1

# Homebrew requires --eval-all to be passed or HOMEBREW_EVAL_ALL to be set to improve security in cases where it may evaluate formulae or casks that have not been installed, may not be trusted and will execute arbitrary Ruby code.
export HOMEBREW_EVAL_ALL=1
