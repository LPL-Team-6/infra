# INFRA

## Docker

Run it:

```sh
docker compose up
```

The frontend is available at http://localhost:4200 and the API at
http://localhost:5020.

Take down:

```sh
docker compose down --remove-orphans
```

## EKS

The EKS stack is separate from the older S3/KMS stack so it has clean state.
It creates a small VPC and one `t3.small` worker:

```sh
cd infra/terraform/eks
terraform init
terraform plan
terraform apply
aws eks update-kubeconfig --region us-east-1 --name caseauth-hackathon
cd ../../..

kubectl apply -f infra/k8s/namespace.yaml
kubectl -n caseauth create secret generic caseauth-secrets \
  --from-literal=POSTGRES_DB=caseauth \
  --from-literal=POSTGRES_USER=caseauth \
  --from-literal=POSTGRES_PASSWORD=hackathon-dev-password \
  --from-literal=ConnectionStrings__Postgres='Host=caseauth-db;Port=5432;Database=caseauth;Username=caseauth;Password=hackathon-dev-password' \
  --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -k infra/k8s
kubectl -n caseauth get svc caseauth-frontend -w
```

Postgres is intentionally ephemeral for the demo. To remove the billable AWS
resources, run `terraform destroy` from `infra/terraform/eks`.

The original `infra/terraform` stack manages S3, KMS, IAM, and Bedrock access
separately and requires `trusted_principle_arn`.
