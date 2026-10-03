# CaseAuth on Kubernetes

The manifests target kind/minikube and use the published GHCR images. They do
not contain credentials. Create the referenced Secret once:

```sh
kubectl create namespace caseauth --dry-run=client -o yaml | kubectl apply -f -
kubectl -n caseauth create secret generic caseauth-secrets \
  --from-literal=POSTGRES_DB=caseauth \
  --from-literal=POSTGRES_USER=caseauth \
  --from-literal=POSTGRES_PASSWORD=hackathon-dev-password \
  --from-literal=ConnectionStrings__Postgres='Host=caseauth-db;Port=5432;Database=caseauth;Username=caseauth;Password=hackathon-dev-password' \
  --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -k infra/k8s
```

For a local demo, expose the frontend:

```sh
kubectl -n caseauth port-forward svc/caseauth-frontend 4200:80
```

Open <http://localhost:4200>. Nginx proxies `/api` to the internal API service.
Postgres uses ephemeral storage for this hackathon deployment, so replacing its
pod resets the demo data.

On EKS, wait for the public frontend address:

```sh
kubectl -n caseauth get svc caseauth-frontend -w
```

Check the rollout and remove the demo with:

```sh
kubectl -n caseauth rollout status deploy/caseauth-db
kubectl -n caseauth rollout status deploy/caseauth-api
kubectl -n caseauth rollout status deploy/caseauth-frontend
kubectl delete namespace caseauth
```
