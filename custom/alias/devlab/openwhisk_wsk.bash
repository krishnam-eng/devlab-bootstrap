# OpenWhisk offers the wsk Command Line Interface (CLI) to easily create, run, and manage OpenWhisk entities.
# https://openwhisk.apache.org/documentation.html

# Before using the OpenWhisk CLI, you must first configure it to point to the **OpenWhisk platform** you want the utility to
# use (i.e., its API endpoint) and also provide it with your associated authentication credentials.
# wsk property set --apihost API_HOST --auth AUTH_KEY --namespace guest

# ignore cert warning for https communication with whisk server. Helpful for local development
alias wsk='wsk -i'

###### Configuration
# view/modify property
alias wskptg='wsk property get'
alias wskpts='wsk property set'

# verify the config
alias wskls='wsk list -v'

# deploy (like helm install/upgrade)
alias wskdp=''

# list all alias in this context
alias mkalias="alias | awk '/^wsk/{print}' | lolcat"