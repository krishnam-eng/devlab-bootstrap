function glA(){
  for git_repo_dir in */.git; do ( echo $git_repo_dir; cd $git_repo_dir/..; git pull; ); done
}
function mvnpA(){
  for git_repo_dir in */.git; do ( echo $git_repo_dir; cd $git_repo_dir/..; mvn --global-settings ~hrt/vault/mvn/settings.xml package; ); done
}