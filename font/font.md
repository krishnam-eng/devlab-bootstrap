Step 1: Download the TTF font files

unzip Hack-v3.003-ttf.zip 

Step 2: Copy TTF files into local fonts directory

mkdir -p ~/.local/share/fonts 

Refresh fonts cache with fc-cache command

fc-cache -f -v 

Review available fonts

fc-list | grep Hack
