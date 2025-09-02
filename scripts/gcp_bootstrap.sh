#!/usr/bin/env bash
set -euo pipefail
PROJECT_ID=${1:?project id}
REGION=${2:-us-central1}
TAG=${3:-dev}
REPO="${REGION}-docker.pkg.dev/${PROJECT_ID}/hello-repo"
IMAGE="${REPO}/hello-flask:${TAG}"
gcloud auth configure-docker ${REGION}-docker.pkg.dev -q
docker build -t ${IMAGE} .
docker push ${IMAGE}
echo "Pushed image: ${IMAGE}"
