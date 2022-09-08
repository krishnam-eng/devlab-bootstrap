# main command
alias ct="crontab"

# list
alias ctls="crontab -l"
alias cte="crontab -e"

# log
alias ctlg="less ~/hrt/var/log/crontab/$(ls -art ~/hrt/var/log/crontab | tail -n 1)"

