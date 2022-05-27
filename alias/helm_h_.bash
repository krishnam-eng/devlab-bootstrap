# Installing your helm chart
# Helm is the de facto Kubernetes package manager
# Helm is a Kubernetes package manager that allows developers and users an easy way to
# package, configure, share, and deploy Kubernetes applications onto Kubernetes clusters.
# You can think of Helm as the same as the Homebrew/APT/Yum package managers, but
# for Kubernetes.


# Helm v3 is based on a client-only architecture. It connects to the Kubernetes API the same
# way as kubectl does, by using a kubeconfig file containing the Kubernetes cluster
# connection settings

# The Helm CLI: A command-line tool that interacts with the Kubernetes API and does various functions, such as installing, upgrading, and deleting Helm releases
# A chart: This is a collection of template files that describe Kubernetes resources
# A repository: A Helm repository is a location where packaged charts are stored and shared
# A release: A specific instance of a chart deployed to a Kubernetes cluster.

#
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

alias hshb='helm search hub'   # search for charts in the Artifact Hub or your own hub instance
alias hsrp='helm search repo' # search repositories for a keyword in charts

alias hshbV='helm search hub --max-col-width=0'   # Verbose: Show repo link and description w/o chart limit
alias hsrpV='helm search repo --max-col-width=0' #

alias hshbY='helm search hub --output yaml'   # Yaml: Show repo link and description as yaml out
alias hsrpY='helm search repo --output yaml'  #

alias hsrpA='helm search repo --max-col-width=0 --versions' # --versions to get all versions

# Showing the details of "chart"
alias hsh='helm show'
alias hshc='helm show chart'
alias hshr='helm show readme'
alias hshv='helm show values'
alias hshA='helm show all'

# Helm Plugin Management
alias hp='helm plugin'

alias hpls='helm plugin list'
alias hpi='helm plugin install'
alias hpu='helm plugin uninstall'
alias hpu='helm plugin update'

# helm plugin install https://github.com/instrumenta/helmkubeval

# package chart
alias hpk='helm package'

# release
alias hi='helm install' # <RELEASE NAME> <CHART NAME>
alias hui='helm uninstall'
alias hu='helm upgrade'
alias hro='helm rollout'

# Inspecting your release
alias hls='helm list --all-namespaces'
alias hh='helm history'

# Get details for a "named release"
alias hg='helm get'
alias hgA='helm get all'
alias hgm='helm get manifest'
alias hgn='helm get notes'
alias hgv='helm get values'
alias hgA='helm get all'


######
# examples
######

# Install the chart
# e.g helm install owdev openwhisk/openwhisk -n openwhisk --create-namespace -f ~hrt/proj/github/homelab-dkrapps/helm/openwhisk/owcluster.yaml
