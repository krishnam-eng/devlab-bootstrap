function gpall(){
  for git_repo_dir in */.git; do ( echo $git_repo_dir; cd $git_repo_dir/..; git pull; ); done
}
