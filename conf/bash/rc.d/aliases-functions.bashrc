
if [ "$(uname)" = "Linux" -o "$(uname)" = "Darwin" ]; then
	for afile in $HOME/hrt/boot/custom/linux/alias/*/*.bash
	do
		source $afile
	done
	unset afile

	for ffile in ~/hrt/boot/custom/linux/func/*.bash
	do
		source $ffile
	done
	unset ffile
fi

if [ "$(uname)" = "Darwin" ]; then
	for afile in ~/hrt/boot/custom/darwin/alias/*.bash
	do
		source $afile
	done
	unset afile
	for ffile in ~/hrt/boot/custom/darwin/func/*.bash
	do
		source $ffile
	done
	unset ffile
fi

# load from local vault - untracted files
 if [[ -d ~/hrt/vault/alias ]]; then
  for vfile in ~/hrt/vault/alias/*.bash
  do
    source $vfile
  done
  unset vfile
 fi