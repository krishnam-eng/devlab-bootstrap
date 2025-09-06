###############
# Load Aliases & Functions
#     to make life easy
#
#     Create: alias name="expand to this"
#            Unset : unalias name
#     Global: alias -g chars   - not just for cmd replacement. just replace anywhere in the full cmd.
#     Suffix: alias -s         -  open file based on suffix
#     Hash  : hash -d namedir=/path/to/dir
##############

if [ "$(uname)" = "Linux" -o "$(uname)" = "Darwin" ]; then
	for afile in $HOME/Paradigm/Development/Root/ctrls/linux/map/*/*sh
	do
		source $afile
	done
	unset afile

	for ffile in $HOME/Paradigm/Development/Root/ctrls/linux/func/*sh
	do
		source $ffile
	done
	unset ffile
fi

if [ "$(uname)" = "Darwin" ]; then
	for afile in $HOME/Paradigm/Development/Root/ctrls/darwin/map/*sh
	do
		source $afile
	done
	unset afile
	for ffile in $HOME/Paradigm/Development/Root/ctrls/darwin/func/*sh
	do
		source $ffile
	done
	unset ffile
fi

# load from local vault - untracted files
 if [[ -d $HOME/Paradigm/Development/Root/Vault/alias ]]; then
  for vfile in $HOME/Paradigm/Development/Root/Vault/alias/*sh
  do
    source $vfile
  done
  unset vfile
 fi

# todo: make them as lazy load using auto load capability or set it in fpath
# Extending your fpath: test and enable the below
# fpath=(~/.myfunc $fpath)