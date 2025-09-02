Terraform creates:
- VPC with subnetwork & secondary ranges (VPC-native requirement)
- GKE Standard cluster + node pool
- Artifact Registry repo

Run:
  terraform init
  terraform apply -auto-approve -var 'project_id=YOUR_PROJECT_ID' -var 'region=us-central1' -var 'zone=us-central1-a'
Then:
  gcloud container clusters get-credentials hello-gke --zone us-central1-a --project YOUR_PROJECT_ID
  kubectl get nodes
