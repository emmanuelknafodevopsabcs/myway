gh auth login
gh repo create $GIT_REPO --public
keptn create project jes-example -y -s jes-hello-world/shipyard.yaml --git-user=$GIT_USER --git-token=$GITHUB_TOKEN --git-remote-url=$GIT_REPO
keptn create service hello --project jes-example -y