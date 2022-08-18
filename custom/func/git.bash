function glA(){
  for git_repo_dir in */.git; do ( echo $git_repo_dir; cd $git_repo_dir/..; git pull; ); done
}
function mvnpA(){
  for git_repo_dir in */.git; do ( echo $git_repo_dir; cd $git_repo_dir/..; mvn --global-settings ~hrt/vault/mvn/settings.xml package; ); done
}
function urp(){
  for git_repo_dir in */.git;
  do
    (
      echo '--------------------<' $git_repo_dir '>--------------------';
      echo $git_repo_dir;
      cd $git_repo_dir/..;
      git pull;
      if [ -e pom.xml ]
      then
          ~/hrt/lib/maven/bin/mvn -U --global-settings ~/.m2/settings.xml package -Dmaven.test.skip=true;
      fi
    )
  done
}
