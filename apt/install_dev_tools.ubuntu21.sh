
# take a log of manually installed packages and its dependent packages
apt list --manual-installed >| ~/github/ohmy-linux/apt/useful_manually_installed-dev_apt-$(date +%Y%m).list 2>/dev/null

