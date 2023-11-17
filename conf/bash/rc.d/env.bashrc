#####
# set env variables
#####
ZDOTDIR=~/hrt/boot/conf/zsh

if [ "$(uname)" = "Linux" -o "$(uname)" = "Darwin" ]; then
  for efile in ~/hrt/boot/custom/linux/env/*.bash
  do
   source $efile
  done
  unset efile
fi

# load from local vault - untracted files
# Load machine specific environment variables
if [[ -d ~/hrt/vault/env ]]; then
	for vfile in ~/hrt/vault/env/*.bash
	do
		source $vfile
	done
	unset vfile
fi

export LOG_TS="${CS_byellow}[${CS_yellow}$(date --utc --rfc-3339=ns)${CS_byellow}] ${CS_reset}"