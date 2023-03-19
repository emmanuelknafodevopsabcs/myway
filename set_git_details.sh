echo "#=================================#"
echo "# Please enter Git details now    #"
echo "#=================================#"
#read -p 'Git Username: ' GIT_USER
#read -p 'Git Token: ' GITHUB_TOKEN
#read -p 'Git Repo to be Created (eg. keptndemo): ' GIT_NEW_REPO_NAME
GITHUB_TOKEN=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
GIT_USER=emmanuelknafodevopsabcs
GIT_NEW_REPO_NAME=myway2

export GIT_REPO=https://github.com/$GIT_USER/$GIT_NEW_REPO_NAME.git
export GIT_USER=$GIT_USER
export GITHUB_TOKEN=$GITHUB_TOKEN
export GIT_NEW_REPO_NAME=$GIT_NEW_REPO_NAME

echo ""
echo "#=================================#"
echo "         Git Details Set:          "
echo "#=================================#"
echo ""
echo "Git Username: $GIT_USER"
echo "Git Token: $GITHUB_TOKEN"
echo "New Git repo to be created: $GIT_REPO"

echo ""
echo "============================================================="
echo "Made a mistake? Easy. Just click the command again on the left to reset everything."
echo "Everything look good? Proceed with the tutorial..."
echo "============================================================="