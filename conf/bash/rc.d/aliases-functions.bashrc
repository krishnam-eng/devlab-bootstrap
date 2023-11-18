
if [ "$(uname)" = "Linux" -o "$(uname)" = "Darwin" ]; then
	for afile in $HOME/hrt/boot/ctrls/linux/map/*/*.bash
	do
		source $afile
	done
	unset afile

	for ffile in $HOME/hrt/boot/custom/linux/func/*.bash
	do
		source $ffile
	done
	unset ffile
fi

if [ "$(uname)" = "Darwin" ]; then
	for afile in $HOME/hrt/boot/ctrls/darwin/map/*.bash
	do
		source $afile
	done
	unset afile
	for ffile in $HOME/hrt/boot/ctrls/darwin/func/*.bash
	do
		source $ffile
	done
	unset ffile
fi

# load from local vault - untracted files
 if [[ -d $HOME/hrt/vault/alias ]]; then
  for vfile in $HOME/hrt/vault/alias/*.bash
  do
    source $vfile
  done
  unset vfile
 fi