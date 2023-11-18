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

## Shell Logic
        **Unary operators that check file characteristics**

        ```
        Option Description
        -b File is a block special device (for files like /dev/hda1)
        -c File is character special (for files like /dev/tty)
        -d File is a directory
        -e File exists
        -f File is a regular file
        -g File has its set-group-ID (setgid) bit set
        -h File is a symbolic link (same as -L)
        -G File is owned by the effective group ID
        -k File has its sticky bit set
        -L File is a symbolic link (same as -h)
        -N File has been modified since it was last read
        -O File is owned by the effective user ID
        -p File is a named pipe
        -r File is readable
        -s File has a size greater than zero
        -S File is a socket
        -u File has its set-user-ID (setuid) bit set
        -w File is writable
        -x File is executable
        ```

        **Explanation of assignment operators in bash**
        ```
        Operator Operation with assignment Use Meaning
        = Simple assignment a=b a=b
        *= Multiplication a*=b a=(a*b)
        /= Division a/=b a=(a/b)
        %= Remainder a%=b a=(a%b)
        += Addition a+=b a=(a+b)
        -= Subtraction a-=b a=(a-b)
<<= Bit-shift left a<<=b a=(a<<b)
        >>= Bit-shift right a>>=b a=(a>>b)
        &= Bitwise “and” a&=b a=(a&b)
        ^= Bitwise “exclusive or” a^=b a=(a^b)
        \ = Bitwise “or” a|=b
        ```

        **Testing for More than One Thing**

        Use the operators for logical AND (-a) and OR (-o) to combine more than one test
        in an expression. For example:
        ```
        if [ -r $FILE -a -w $FILE ]
        ```

        **Testing for String Characteristics**
        ```
        if [ -z "$VAR" ]
        then
        echo zero length
        else
        echo has text
        fi
        ```

        **Testing for Equality**
        The type of comparison you need determines which operator you should use. Use the
        -eq operator for numeric comparisons and the equality primary = (or ==) for string
        comparisons

