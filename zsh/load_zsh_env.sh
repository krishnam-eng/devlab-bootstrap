

# it's a good idea to backup existing files first
mkdir -p bkconf
find ~ -type f -maxdepth 1 -name '.zsh*' -exec cp {} {}.bak \;
