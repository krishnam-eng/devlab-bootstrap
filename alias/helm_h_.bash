# Installing your helm chart

alias h='helm'

# Package Repo Management
alias hr='helm repo'

alias hrls='helm repo list'   # list chart repositories
alias hra='helm repo add'     # add a chart repository
alias hrrm='helm repo remove' # remove one or more chart repositories
alias hru='helm repo update'  # update information of available charts locally from chart repositories
alias hri='helm repo index'   # generate an index file given a directory containing packaged charts

# Search and Find the Chart
alias hs='helm search'
alias hsh='helm search hub'   # search for charts in the Artifact Hub or your own hub instance
alias hsrp='helm search repo' # search repositories for a keyword in charts

alias hshbV='helm search hub --max-col-width=0'   # Show repo link and description w/o chart limit
alias hsrpV='helm search repo --max-col-width=0' #
