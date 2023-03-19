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
$GIT_NEW_REPO_NAME = "myway7" #create manually

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
keptn create project jes-example -y -s jes-hello-world/shipyard.yaml --git-user=$GIT_USER --git-token=$GITHUB_TOKEN --git-remote-url=$GIT_REPO
keptn create service hello --project jes-example -y

#Add a simple "Hello world!" job config to production stage for service hello as job/config.yaml

keptn add-resource --project jes-example --service hello --stage production --resource jes-hello-world/jobconfig.yaml --resourceUri job/config.yaml
#Trigger the example-seq sequence.

keptn trigger sequence example-seq --project jes-example --service hello --stage production