## zsh Configuration Files

zsh has a list of files it will execute at shell startup. The list of possible files is even longer, but somewhat more ordered.

```
+----------------+-----------+-----------+------+
|                |Interactive|Interactive|Script|
|                |login      |non-login  |      |
+----------------+-----------+-----------+------+
|/etc/zshenv     |    A      |    A      |  A   |
+----------------+-----------+-----------+------+
|~/.zshenv       |    B      |    B      |  B   |
+----------------+-----------+-----------+------+
|/etc/zprofile   |    C      |           |      |
+----------------+-----------+-----------+------+
|~/.zprofile     |    D      |           |      |
+----------------+-----------+-----------+------+
|/etc/zshrc      |    E      |    C      |      |
+----------------+-----------+-----------+------+
|~/.zshrc        |    F      |    D      |      |
+----------------+-----------+-----------+------+
|/etc/zlogin     |    G      |           |      |
+----------------+-----------+-----------+------+
|~/.zlogin       |    H      |           |      |
+----------------+-----------+-----------+------+
+----------------+-----------+-----------+------+
|~/.zlogout      |    I      |           |      |
+----------------+-----------+-----------+------+
|/etc/zlogout    |    J      |           |      |
+----------------+-----------+-----------+------+
```
`bash --login --noprofile` => to skip reading from profile
`--norc` = > to skip rc file


#### Why So Many Files?
The files in /etc/ will be launched (when present) for all users. The .z* files only for the individual user.

- zsh will start with /etc/zshenv, then the user’s .zshenv. The zshenv files are always used when they exist, even for scripts with the #!/bin/zsh shebang. Since changes applied in the zshenv will affect zsh behavior in all contexts, you should you should be very cautious about changes applied here.
- Next, when the shell is a login shell, zsh will run /etc/zprofile and .zprofile. Then for interactive shells (and login shells) /etc/zshrc and .zshrc. Then, again, for login shells /etc/zlogin and .zlogin. Why are there two files for login shells? The zprofile exists as an analog for bash’s and sh’s profile files, and zlogin as an analog for ksh login files.
- Finally, there are zlogout files that can be used for cleanup, when a login shell exits. In this case, the user level .zlogout is read first, then the central /etc/zlogout.

#### Can I Change the Config Path?
By default, zsh will look in the root of the home directory for the user .z* files, but this behavior can be changed by setting the ZDOTDIR environment variable to another directory (e.g. ~/.myzsh/) where you can then group all user zsh configuration in one place.

###### Proper way to set $ZDOTDIR?

If it needs to be set via user session (not globally) and needs to be portable (relative path), there is practically only one way it can reliably work and be portable - setting zdotdir in your $HOME/.zshenv and the rest of your configuration in $ZDOTDIR/...

🧰 **What's this**

_It consists of ready-to-use config files and more of my Linux setup and development environment._

To create an efficient Linux developer environment, it's a runbook to use to quickly customize and learn 'Tips n Tricks' of various tools; to quickly install and configure required development tools.

🔩 **How/Why It Got Created**

Learn, practice and check-in what-worked-well
- To learn the depth of Linux, shells, various dev tools capabilities in the context of dev productivity
- To capture 'Up n Running' & 'Tips n Tricks' along with the learning notes
- To create ready to use configs to start with 

🚀 **When To Use**

- To manage personal customization to zsh, bash, nano, tmux configurations for boosting productivity. 
- To reuse the same config in any new Linux dev environment

✍️ **My Related Blogs**

- [tmux: 13 Cool Tweaks to Make It Personal and Powerful](https://dev.to/krishnam/tmux-13-cool-tweaks-to-make-it-personal-and-powerful-487p)
- [Productivity Booster: Command Line Happiness with tmux](https://dev.to/krishnam/dev-productivity-command-line-happiness-with-terminal-multiplexing-5067)
>>>>>>> Stashed changes
