GITEA_ADMIN_USERNAME=GiteaAdmin
GITEA_NAMESPACE=gitea
GITEA_ADMIN_PASSWORD=$(date +%s | sha256sum | base64 | head -c 32)

export GITEA_ENDPOINT="http://gitea-http.${GITEA_NAMESPACE}:3000"

helm repo add gitea-charts https://dl.gitea.io/charts/
helm repo update
helm install -n ${GITEA_NAMESPACE} gitea gitea-charts/gitea \
  --create-namespace \
  --set memcached.enabled=false \
  --set postgresql.enabled=false \
  --set gitea.config.database.DB_TYPE=sqlite3 \
  --set gitea.admin.username=${GITEA_ADMIN_USERNAME} \
  --set gitea.admin.password=${GITEA_ADMIN_PASSWORD} \
  --set gitea.config.server.OFFLINE_MODE=true \
  --set gitea.config.server.ROOT_URL=${GITEA_ENDPOINT}/ \
  --wait


helm install keptn-gitea-provisioner-service https://github.com/keptn-sandbox/keptn-gitea-provisioner-service/releases/download/0.1.1/keptn-gitea-provisioner-service-0.1.1.tgz \
  --set gitea.endpoint=${GITEA_ENDPOINT} \
  --set gitea.admin.create=true \
  --set gitea.admin.username=${GITEA_ADMIN_USERNAME} \
  --set gitea.admin.password=${GITEA_ADMIN_PASSWORD} \
  --wait
