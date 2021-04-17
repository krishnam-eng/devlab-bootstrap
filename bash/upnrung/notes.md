#### Passing Arguments to Bash Functions
To pass any number of arguments to the bash function simply put them right after the function’s name, separated by a space. It is a good practice to double-quote the arguments to avoid the misparsing of an argument with spaces in it.

- The passed parameters are $1, $2, $3 … $n, corresponding to the position of the parameter after the function’s name.
- The $0 variable is reserved for the function’s name.
- The $# variable holds the number of positional parameters/arguments passed to the function.
- The $* and $@ variables hold all positional parameters/arguments passed to the function.
	- When double-quoted, "$*" expands to a single string separated by space (the first character of IFS) - "$1 $2 $n"
	- When double-quoted, "$@" expands to separate strings - "$1" "$2" "$n".
	- When not double-quoted, $* and $@ are the same.
