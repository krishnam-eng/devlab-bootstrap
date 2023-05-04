#!/bin/bash

# Define log function
tlog() {
  local level=$1
  local message=$2
  local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  printf "${CS_bcyan}${timestamp} ${CS_reset}${level}${CS_reset} ${message}\n"
}

# Example usage
tlog $INFO "Starting script"
tlog $WARN "This is a warning"
tlog $ERROR "This is an error"
tlog $INFO "Script complete"
tlog $TRACE "Starting trace"
tlog $FATAL "This is a fatal"
tlog $DEBUG "This is an debug"
