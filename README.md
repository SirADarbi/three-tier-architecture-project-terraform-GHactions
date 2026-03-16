# Three-Tier AWS Architecture — Terraform

This project provisions a three-tier architecture on AWS using Terraform.

---

## What it does

The infrastructure is split into three layers:

- **Web tier** — A public-facing Application Load Balancer routes traffic to EC2 instances in an Auto Scaling Group across two availability zones
- **App tier** — An internal ALB sits in front of a second ASG in private subnets. The web servers talk to the app servers, but nothing from the internet can reach here directly
- **Data tier** — A PostgreSQL RDS instance in isolated subnets (no route to the internet at all) with Multi-AZ enabled for failover

The networking is set up so that each layer can only talk to the one directly below it. Security groups enforce this at the resource level.

---

## Project layout

```
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── backend.tf
├── .github/workflows/
│   ├── terraform.yml
│   └── terraform-destroy.yml
└── modules/
    ├── networking/
    ├── security/
    ├── web/
    ├── app/
    └── data/
```

---

## CI/CD

Push to `main` and the GitHub Actions pipeline handles the rest. It runs secret scanning with Gitleaks, formats and validates the Terraform code, runs a security scan with tfsec, then plans and applies.

Pull requests only go up to `terraform plan` so you can review changes before they go out.

There's also a manual destroy workflow under the Actions tab if you need to tear everything down.

---

## Setup

Add these secrets to your GitHub repo before running:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`
- `DB_USERNAME`
- `DB_PASSWORD`

Then push to `main`. The pipeline creates the S3 state bucket on first run if it doesn't exist yet.
