# store all information related to kernel events
alias klog="/var/log/kern.log"

# store all global system activity data, including startup messages
# For RHEL, /var/log/messages
alias slog="tail -f /var/log/syslog"

# store all information related to authentication and authorization
# - such as logins, root user actions, and output from pluggable authentication modules (PAM)
# For RHEL, /var/log/secure
alias alog="tail -f /var/log/auth.log"
alias flog="tail -f /var/log/faillog"