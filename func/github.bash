function gpall(){
  for git_repo_dir in */.git; do ( echo $git_repo_dir; cd $git_repo_dir/..; git pull; ); done
}

function ghclone(){
  repo=$1
  gitusr=${2="krishnam-eng"}

  mkdir -p ~/hrt/proj/github
  echo "${LOG_TS} Cloning repo from ${CS_bcyan}github.com:${gitusr}${CS_reset}..."
  git clone git@github.com:krishnam-eng/$repo ~/hrt/proj/github/$repo

  echo "${LOG_TS} Configuring git repo ${CS_bcyan}$repo${CS_reset}..."

  cd ~/hrt/proj/github/$repo
  git config --local user.email "krishnam.balamurugan.eng@gmail.com"

  # todo: set all global based on if the git is used for first time or not
  git config --global user.name "balamurugan"
  git config --global pull.rebase false
  git config --global core.editor nano
  git config --global core.autocrlf input # if file got CRLF, change it to LF when git add

  git config --global core.excludesfile ~/hrt/hldr/git/.gitignore_global

  git config --global rebase.autosquash true

  # todo: install kdiff3
  git config --global diff.tool kdiff3
  git config --global merge.tool kdiff3

  echo "${LOG_TS} List config for ${CS_bgreen}global${CS_reset} scope..."
  git config --global --list

  echo "${LOG_TS} List config for ${CS_green}local${CS_reset} scope..."
  git config --local --list
}

