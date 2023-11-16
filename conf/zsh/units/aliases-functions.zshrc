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

 if [[ -d $HOME/hrt/boot/custom/alias ]]; then
  for afile in $HOME/hrt/boot/custom/alias/*/*sh
  do
    source $afile
  done
  unset afile
 fi

 if [[ -d ~/hrt/boot/custom/macos ]]; then
  for afile in ~/hrt/boot/custom/macos/*alias.bash
  do
    source $afile
  done
  unset afile
 fi

 if [[ -d ~/hrt/vault/alias ]]; then
  for vfile in ~/hrt/vault/alias/*sh
  do
    source $vfile
  done
  unset vfile
 fi

if [ -d ~/hrt/boot/custom/func ]; then
  for ffile in ~/hrt/boot/custom/func/*sh
  do
    source $ffile
  done
  unset ffile
fi

if [ -d ~/hrt/boot/custom/macos ]; then
  for ffile in ~/hrt/boot/custom/macos/*func.bash
  do
    source $ffile
  done
  unset ffile
fi

# todo: make them as lazy load using auto load capability or set it in fpath
# Extending your fpath: test and enable the below
# fpath=(~/.myfunc $fpath)