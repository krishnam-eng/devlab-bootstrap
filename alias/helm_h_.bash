# Installing your helm chart

alias h='helm'

# Package Repo Management
alias hr='helm repo'

alias hrls='helm repo list'   # list chart repositories
alias hra='helm repo add'     # add a chart repository
alias hrrm='helm repo remove' # remove one or more chart repositories
alias hru='helm repo update'  # update information of available charts locally from chart repositories
alias hri='helm repo index'   # generate an index file given a directory containing packaged charts

# Helm Plugin Management
alias hp='helm plugin'

alias hpls='helm plugin list'
alias hpi='helm plugin install'
alias hpu='helm plugin uninstall'
alias hpu='helm plugin update'

# Search and Find the Chart
alias hs='helm search'

alias hshb='helm search hub'   # search for charts in the Artifact Hub or your own hub instance
alias hsrp='helm search repo' # search repositories for a keyword in charts

alias hshbV='helm search hub --max-col-width=0'   # Verbose: Show repo link and description w/o chart limit
alias hsrpV='helm search repo --max-col-width=0' #

alias hshbY='helm search hub --output yaml'   # Yaml: Show repo link and description as yaml out
alias hsrpY='helm search repo --output yaml'  #

# --versions to get all versions
alias hsrpA='helm search repo --max-col-width=0 --versions'

# Showing the details
alias hsh='helm show'
alias hshc='helm show chart'
alias hshr='helm show readme'
alias hshv='helm show values'
alias hshA='helm show all'

# Install the chart


# Inspecting your release
alias hls='helm list'

# Get details for a named release
alias hg='helm get'
alias hgA='helm get all'
alias hgm='helm get manifest'
alias hgn='helm get notes'
alias hgv='helm get values'
alias hgA='helm get all'
