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
# echo 'Load Aliases and Functions...'

# load all alias files with `source filename` or `. filename` (. is posix std way)
 if [[ -d ~/hrt/boot/custom/alias ]]; then
  for afile in ~/hrt/boot/custom/alias/*sh
  do
    # echo $LOG_TS"Sourcing ${afile} ..."
    source $afile
  done
  unset afile
 fi

 if [[ -d ~/hrt/boot/custom/macos ]]; then
  for afile in ~/hrt/boot/custom/macos/*alias.bash
  do
    # echo $LOG_TS"Sourcing ${afile} ..."
    source $afile
  done
  unset afile
 fi

# load all alias / func / env files from private dir
# secret dir is version with private repo
 if [[ -d ~/hrt/secret/zsh-alias ]]; then
  for pfile in ~/hrt/secret/zsh-alias/*zsh
  do
    # echo $LOG_TS"Sourcing ${pfile} ..."
    source $pfile
  done
  unset pfile
 fi

# todo: make them as lazy load using auto load capability or set it in fpath
if [ -d ~/hrt/boot/custom/func ]; then
  for ffile in ~/hrt/boot/custom/func/*sh
  do
    # echo $LOG_TS"Sourcing ${ffile} ..."
    source $ffile
  done
  unset ffile
fi

# todo: make them as lazy load using auto load capability or set it in fpath
if [ -d ~/hrt/boot/custom/macos ]; then
  for ffile in ~/hrt/boot/custom/macos/*func.bash
  do
    # echo $LOG_TS"Sourcing ${ffile} ..."
    source $ffile
  done
  unset ffile
fi

# Extending your fpath
#
# test and enable the below
# fpath=(~/.myfunc $fpath)