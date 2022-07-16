alias b='brew'

# list all alias in this context
alias balias="alias | awk '/^b/{print}' | lolcat"

# Pin a specified formula so that it's not upgraded.
alias bp='brew pin'

# List installed formulae or the installed files for a given formula.
alias bls='brew list -1'

# List pinned formulae, or show the version of a given formula.
alias blsp='brew list --pinned'

# Update Homebrew data, then list outdated formulae and casks.
alias bubo='brew update && brew outdated'

# Upgrade outdated formulae and casks, then run cleanup.
alias bubc='brew upgrade && brew cleanup'

# Do the last two operations above.
alias bubu='bubo && bubc'

# Upgrade only formulas (not casks).
alias buf='brew upgrade --formula'

# Update Homebrew data, then list outdated casks.
alias bcubo='brew update && brew outdated --cask'

# Update outdated casks, then run cleanup.
alias bcubc='brew upgrade --cask && brew cleanup'
