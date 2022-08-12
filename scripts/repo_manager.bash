#!/bin/bash
for git_repo_dir in */.git
do
    echo 'Stage: Update Repo - '$git_repo_dir
    cd $git_repo_dir/..
    echo 'Step: Git Pull'
    git pull
    if [ -e pom.xml ]
    then
        echo 'Step: Maven Package'
        mvn --global-settings ~/hrt/vault/mvn/settings.xml package -Dmaven.test.skip=true
    fi
done