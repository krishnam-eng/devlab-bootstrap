#!/bin/bash
for git_repo_dir in */.git
do
    echo '--------------------<' $git_repo_dir '>--------------------'
    cd $git_repo_dir/..
    echo 'Step: Git Pull'
    git pull
    if [ -e pom.xml ]
    then
        echo 'Step: Maven Package'
        mvn --global-settings ~/hrt/vault/mvn/settings.xml package -Dmaven.test.skip=true
    fi
done

# todos: echo color code it 
#! Ignore only the warning in mvn -q removes all -X puts all - find middle ground