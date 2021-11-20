#!/usr/bin/env bash

alias k="kubectl"

#--------------------------------------------------
# Kubernetes Aliases
# (grouped by usage and then sorted alphabetically)
#--------------------------------------------------

###### Viewing, finding resources

alias kg="kubectl get"

alias kgno="kubectl get nodes"
alias kgrc="kubectl get replicationcontroller"
alias kgpo="kubectl get pods"
alias kgsvc="kubectl get services"
alias kgns="kubectl get namespaces"

alias kd="kubectl describe" 

alias kdpo="kubectl describe pods" 
alias kdno="kubectl describe nodes" 

alias kr="kubectl run" 



# https://phoenixnap.com/kb/kubectl-commands-cheat-sheet