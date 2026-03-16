# Three-Tier AWS Architecture — Terraform

This project provisions a three-tier architecture on AWS using Terraform.

---

## Overview

The infrastructure is split into three layers:

- **Web tier** — A public-facing Application Load Balancer routes traffic to EC2 instances in an Auto Scaling Group across two availability zones
- **App tier** — An internal ALB sits in front of a second ASG in private subnets. The web servers talk to the app servers, but nothing from the internet can reach here directly
- **Data tier** — A PostgreSQL RDS instance in isolated subnets (no route to the internet at all) with Multi-AZ enabled for failover

---

## Diagram

<img width="1891" height="791" alt="diagram-export-16-03-2026-13_57_50" src="https://github.com/user-attachments/assets/9b676495-f945-4ae6-92af-785a1420794c" />

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

## Modules

Each layer of the architecture lives in its own module under the `modules/` directory. The root `main.tf` calls each module and wires them together by passing outputs from one as inputs to another If you wanted to swap out the database or change the networking setup, you only touch that one module.

Every module has three files:

- `main.tf` — the resources being created
- `variables.tf` — what the module needs as input
- `outputs.tf` — what the module exposes to other modules or the root

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
