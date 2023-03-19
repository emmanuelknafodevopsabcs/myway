$BRIDGE_USERNAME = kubectl get secret -n keptn bridge-credentials -o jsonpath="{.data.BASIC_AUTH_USERNAME}" > brideUsername.txt
base64 -d -i brideUsername.txt -o brideUsernameOut.txt 
$BRIDGE_USERNAME = Get-Content .\brideUsernameOut.txt
$BRIDGE_PASSWORD = kubectl get secret -n keptn bridge-credentials -o jsonpath="{.data.BASIC_AUTH_PASSWORD}" > bridePassword.txt
base64 -d -i bridePassword.txt -o bridePasswordOut.txt 
$BRIDGE_PASSWORD = Get-Content .\bridePasswordOut.txt
Write-Host "Bridge Username: $BRIDGE_USERNAME"
Write-Host "Bridge Password: $BRIDGE_PASSWORD"

$API_TOKEN = kubectl get secret keptn-api-token -n keptn -ojsonpath='{.data.keptn-api-token}' | base64 -d
Write-Host $API_TOKEN
keptn auth --endpoint=http://192.168.102.38/api --api-token=$API_TOKEN

$GITHUB_TOKEN = "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"
$GIT_USER = "emmanuelknafodevopsabcs"
$GIT_NEW_REPO_NAME = "myway8" #create manually

$GIT_REPO = "https://github.com/$GIT_USER/$GIT_NEW_REPO_NAME.git"

echo ""
echo "#=================================#"
echo "         Git Details Set:          "
echo "#=================================#"
echo ""
echo "Git Username: $GIT_USER"
echo "Git Token: $GITHUB_TOKEN"
echo "New Git repo to be created: $GIT_REPO"

#gh repo create $GIT_REPO --public

$PROJECT = "podtato-head"
keptn create project $PROJECT --shipyard=./shipyard.yaml --git-user=$GIT_USER --git-token=$GITHUB_TOKEN --git-remote-url=$GIT_REPO