# output format (works with kubectl)
alias -g OY='--output yaml'
alias -g OW='--output wide'
alias -g OJ='--output json'


# Out Yaml - will create yaml resource config from the running k8s resource
# e.g, kubectl get service nginx -o yaml > service.xml
