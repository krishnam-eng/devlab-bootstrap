#!/usr/bin/env bash

# use this for log prefix
# (bug: breaks in mac) export LOG_TS="${CS_byellow}[${CS_yellow}$(date --utc --rfc-3339=ns)${CS_byellow}] ${CS_reset}"
export LOG_TS="${CS_byellow}[${CS_yellow}$(date -u)${CS_byellow}] ${CS_reset}"

# Define log levels color code
export TRACE="[${CS_magenta}TRACE${CS_reset}]"
# DEBUG env will mess up with kubectl exec cmd
# export DEBUG="[${CS_blue}DEBUG${CS_reset}]"
export INFO="[${CS_green}INFO${CS_reset}]"
export WARN="[${CS_yellow}WARN${CS_reset}]"
export ERROR="[${CS_red}ERROR${CS_reset}]"
export FATAL="[${CS_red_bd}FATAL${CS_reset}]"