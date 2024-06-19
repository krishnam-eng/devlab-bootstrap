
if [ "$(uname)" = "Linux" -o "$(uname)" = "Darwin" ]; then
	for afile in $HOME/Paradigm/Development/Root/ctrls/linux/map/*/*.bash
	do
		source $afile
	done
	unset afile

	for ffile in $HOME/Paradigm/Development/Root/custom/linux/func/*.bash
	do
		source $ffile
	done
	unset ffile
fi

if [ "$(uname)" = "Darwin" ]; then
	for afile in $HOME/Paradigm/Development/Root/ctrls/darwin/map/*.bash
	do
		source $afile
	done
	unset afile
	for ffile in $HOME/Paradigm/Development/Root/ctrls/darwin/func/*.bash
	do
		source $ffile
	done
	unset ffile
fi

# load from local vault - untracted files
 if [[ -d $HOME/Paradigm/Development/Vault/alias ]]; then
  for vfile in $HOME/Paradigm/Development/Vault/alias/*.bash
  do
    source $vfile
  done
  unset vfile
 fi