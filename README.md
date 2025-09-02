# Hello Flask on **GKE** — Starter Kit (GCP)

End-to-end learning project: Flask API → Docker → **Artifact Registry** → **GKE** → Helm → Postman → (optional) GitHub Actions (WIF).

## 0) First-time GCP setup
1) Create a **Project** and enable **Billing** in the Cloud Console.  
2) Install the **gcloud** CLI and login:
   ```bash
   gcloud auth login
   gcloud config set project YOUR_PROJECT_ID
   gcloud config set compute/region us-central1
   gcloud config set compute/zone us-central1-a
   gcloud components install kubectl
   ```

## 1) Provision infra with Terraform
```bash
cd terraform
terraform init
terraform apply -auto-approve -var 'project_id=YOUR_PROJECT_ID' -var 'region=us-central1' -var 'zone=us-central1-a'
gcloud container clusters get-credentials hello-gke --zone us-central1-a --project YOUR_PROJECT_ID
kubectl get nodes
```
Terraform enables APIs, creates VPC-native GKE and Docker Artifact Registry.

## 2) Build & push the image
```bash
./scripts/gcp_bootstrap.sh YOUR_PROJECT_ID us-central1 dev
```
This builds and pushes `us-central1-docker.pkg.dev/YOUR_PROJECT_ID/hello-repo/hello-flask:dev`.

## 3) Deploy with Helm
```bash
./scripts/deploy_helm_gke.sh hello YOUR_PROJECT_ID us-central1-a us-central1 dev
kubectl get svc hello-hello -w
```
Use the EXTERNAL-IP from the service as your Postman `baseUrl`.

## 4) Test with Postman
Import the collection and environment from `postman/` and set `baseUrl`.

## 5) CI (optional) with GitHub Actions + WIF
Create a Workload Identity Pool/Provider and a GCP Service Account with Artifact Registry Writer; store:
- `GCP_PROJECT_ID`
- `GCP_WORKLOAD_IDENTITY_PROVIDER`
- `GCP_SERVICE_ACCOUNT_EMAIL`
in GitHub repo secrets. Push to `main` to build & push automatically.

## 6) Observability
Quick start:
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm upgrade --install mon prometheus-community/kube-prometheus-stack -n monitoring --create-namespace
# set enableServiceMonitor=true in helm/hello/values.yaml and redeploy
```
Advanced: use **Managed Service for Prometheus** later.

## Cleanup
```bash
helm uninstall hello
helm uninstall mon -n monitoring || true
cd terraform && terraform destroy -auto-approve -var 'project_id=YOUR_PROJECT_ID'
```
# trigger
# trigger CI
# trigger deploy
