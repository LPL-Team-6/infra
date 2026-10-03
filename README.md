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

## Terraform

For our AWS right now we have an s3 bucket and some iam roles, as well as a
bedrock.

To start, go to the terraform directory and run:

```sh
terraform plan
```

You will need to have your user arn ready to paste into the terraform.

To deploy services:

```sh
terraform apply
```

And destroy:

```sh
terraform destroy
```
