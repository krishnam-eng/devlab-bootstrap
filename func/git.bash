function ghclone(){
  repo=$1
  gitusr=${2="krishnam-eng"}

  echo "${LOG_TS} Cloning repo from ${CS_bcyan}github.com:${gitusr}${CS_reset}..."
  git clone git@github.com:krishnam-eng/$repo ~/github/$repo

  echo "${LOG_TS} Configuring git repo ${CS_bcyan}$repo${CS_reset}..."
  cd ~/github/$repo
  git config --local user.email "krishnam.balamurugan.eng@gmail.com"

  # todo: set all global based on if the git is used for first time or not
  git config --global user.name "krishnam"
  git config --global pull.rebase false
  git config --global core.editor nano
  git config --global core.autocrlf input # if file got CRLF, change it to LF when git add

  if [ ! -f ~/.mygit/.gitignore_global ]
  then
    mkdir -p ~/.mygit
    echo '*~' > ~/.mygit/.gitignore_global
    echo '.*.swp' >> ~/.mygit/.gitignore_global
  fi
  git config --global core.excludesfile ~/.mygit/.gitignore_global

  git config --global rebase.autosquash true

  # todo: install kdiff3
  git config --global diff.tool kdiff3
  git config --global merge.tool kdiff3

  echo "${LOG_TS} List config ${CS_bgreen} global ${CS_reset}..."
  git config --global --list

  echo "${LOG_TS} List config ${CS_green} local ${CS_reset}..."
  git config --local --list
}
