## zsh Configuration Files

zsh has a list of files it will execute at shell startup. The list of possible files is even longer, but somewhat more ordered.

|all users     |	user	  |login shell |interactive shell|	scripts| terminal app|
|--------------|----------|------|------|-----------------|---------------------|
|/etc/zshenv	 |.zshenv	  |√	   |√	    |√	              | √                   |
|/etc/zprofile |.zprofile	|√	   |x	    |x	              |	√                   |
|/etc/zshrc	   |.zshrc	  |√	   |√	    |x	              |	√                   |
|/etc/zlogin	 |.zlogin	  |√	   |x	    |x	              |	√                   |
|/etc/zlogout	 |.zlogout	|√	   |x	    |x	              |	√                   |

#### Why So Many Files?
The files in /etc/ will be launched (when present) for all users. The .z* files only for the individual user.

- zsh will start with /etc/zshenv, then the user’s .zshenv. The zshenv files are always used when they exist, even for scripts with the #!/bin/zsh shebang. Since changes applied in the zshenv will affect zsh behavior in all contexts, you should you should be very cautious about changes applied here.
- Next, when the shell is a login shell, zsh will run /etc/zprofile and .zprofile. Then for interactive shells (and login shells) /etc/zshrc and .zshrc. Then, again, for login shells /etc/zlogin and .zlogin. Why are there two files for login shells? The zprofile exists as an analog for bash’s and sh’s profile files, and zlogin as an analog for ksh login files.
- Finally, there are zlogout files that can be used for cleanup, when a login shell exits. In this case, the user level .zlogout is read first, then the central /etc/zlogout. 

#### Can I Change the Config Path?
By default, zsh will look in the root of the home directory for the user .z* files, but this behavior can be changed by setting the ZDOTDIR environment variable to another directory (e.g. ~/.zsh/) where you can then group all user zsh configuration in one place.

###### Proper way to set $ZDOTDIR?
If it needs to be set via user session (not globally) and needs to be portable (relative path), there is practically only one way it can reliably work and be portable - setting zdotdir in your $HOME/.zshenv and the rest of your configuration in $ZDOTDIR/...
