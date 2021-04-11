## zsh Configuration Files

zsh has a list of files it will execute at shell startup. The list of possible files is even longer, but somewhat more ordered.

The files in /etc/ will be launched (when present) for all users. The .z* files only for the individual user.

By default, zsh will look in the root of the home directory for the user .z* files, but this behavior can be changed by setting the ZDOTDIR environment variable to another directory (e.g. ~/.zsh/) where you can then group all user zsh configuration in one place.

### Proper way to set $ZDOTDIR?
If it needs to be set via user session (not globally) and needs to be portable (relative path), there is practically only one way it can reliably work and be portable - setting zdotdir in your $HOME/.zshenv and the rest of your configuration in $ZDOTDIR/...
