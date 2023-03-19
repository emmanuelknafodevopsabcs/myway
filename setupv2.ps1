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
$GIT_NEW_REPO_NAME = "myway9" #create manually

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
keptn create service helloservice --project=$PROJECT

keptn add-resource --project=$PROJECT --service=helloservice --all-stages --resource=./helm/helloservice.tgz --resourceUri=charts/helloservice.tgz

keptn add-resource --project=$PROJECT --service=helloservice --stage=qa --resource=./locust/basic.py
keptn add-resource --project=$PROJECT --service=helloservice --stage=qa --resource=./locust/locust.conf

keptn add-resource --project=$PROJECT --service=helloservice --all-stages --resource=job-executor-config.yaml --resourceUri=job/config.yaml

keptn add-resource --project=$PROJECT --service=helloservice --stage=qa --resource=prometheus/sli.yaml --resourceUri=prometheus/sli.yaml
keptn add-resource --project=$PROJECT --service=helloservice --stage=qa --resource=slo.yaml --resourceUri=slo.yaml

keptn configure monitoring prometheus --project=$PROJECT --service=helloservice

keptn add-resource --project=$PROJECT --service=helloservice --stage=production --resource=remediation.yaml

$IMAGE = "ghcr.io/podtato-head/podtatoserver"
$VERSION = "v0.1.1"
$SLOW_VERSION = "v0.1.2"

$imageVersion = "${IMAGE}:${VERSION}"
echo $imageVersion

keptn trigger delivery --project=$PROJECT --service=helloservice --image=$imageVersion --labels=version=$VERSION