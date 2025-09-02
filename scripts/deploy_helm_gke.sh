#!/usr/bin/env bash
set -euo pipefail
REL=${1:-hello}
PROJECT_ID=${2:?project id}
ZONE=${3:-us-central1-a}
REGION=${4:-us-central1}
TAG=${5:-dev}
gcloud container clusters get-credentials hello-gke --zone ${ZONE} --project ${PROJECT_ID}
REPO="${REGION}-docker.pkg.dev/${PROJECT_ID}/hello-repo/hello-flask"
helm upgrade --install "$REL" helm/hello   --set image.repository=$REPO   --set image.tag=$TAG
kubectl rollout status deploy/${REL}-hello
kubectl get svc ${REL}-hello -w
