#!/usr/bin/env bash

# Define log levels color code
export TRACE="[${CS_magenta}TRACE${CS_reset}]"
# DEBUG env will mess up with kubectl exec cmd
# export DEBUG="[${CS_blue}DEBUG${CS_reset}]"
export INFO="[${CS_green}INFO${CS_reset}]"
export WARN="[${CS_yellow}WARN${CS_reset}]"
export ERROR="[${CS_red}ERROR${CS_reset}]"
export FATAL="[${CS_red_bd}FATAL${CS_reset}]"