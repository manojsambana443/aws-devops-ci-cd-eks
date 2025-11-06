# AWS DevOps Project — GitHub Actions → ECR → EKS (with Terraform, HPA, Monitoring, Logging)

**Goal:** A recruiter-ready, industry-standard project for a 2-year DevOps engineer:
- CI/CD with **GitHub Actions** (OIDC auth to AWS, no long-lived keys)
- Container images in **Amazon ECR**
- Deploy to **Amazon EKS** with health probes, rollout, and **HPA**
- Infra via **Terraform** (VPC, EKS, ECR)
- **Monitoring** (Prometheus + Grafana) and **Logging** (Fluent Bit → CloudWatch)
- Minimal sample app (Python HTTP server)

---

## High-Level Architecture

```
Developer → GitHub → Actions (CI/CD)
      |        |        └─ Build/Test → Docker → Push to ECR
      |        |                               └─ kubectl apply → EKS (Deployment/Service/Ingress/HPA)
      |        └─ OIDC → IAM role (no static keys)
Users → AWS ALB (Ingress) → Service → Pods
                   ├─ HPA (CPU)
                   ├─ Prometheus → Grafana (metrics/dashboards)
                   └─ Fluent Bit → CloudWatch Logs (centralized logs)
```

---

## What to Replace (Search & Replace Before First Run)
- `<AWS_REGION>` → e.g., `ap-south-1`
- `<AWS_ACCOUNT_ID>` → your account ID
- `<EKS_CLUSTER_NAME>` → e.g., `demo-eks`
- `<GHA_OIDC_ROLE_NAME>` → IAM role name assumed by GitHub
- `<ECR_REPO_NAME>` → e.g., `demo-web`

---

## Quickstart

### 1) Provision Infra (Terraform)
```bash
cd terraform
terraform init
terraform apply -var='aws_region=ap-south-1' -auto-approve
# Output shows: ECR repo URL and a kubeconfig update command.
```

### 2) (One-time) Configure GitHub OIDC → IAM
- Create an IAM role with trust policy for GitHub OIDC and grant `ECR`, `EKS`, and minimal `STS` permissions.
- Put that role ARN into workflow `role-to-assume`.

### 3) Wire Kubeconfig in Runner
Workflow runs: `aws eks update-kubeconfig --name <EKS_CLUSTER_NAME> --region <AWS_REGION>`

### 4) Push Code
- On push to `main`, CI builds Docker, pushes to ECR, replaces the image in K8s Deployment, and applies manifests.

---

## Local Sanity Check
```bash
docker build -t demo-web:local .
docker run -p 8080:8080 demo-web:local
curl http://localhost:8080
```

---

## Resume Statement (Copy/Paste)

Designed and implemented GitHub Actions CI/CD for a containerized microservice deployed to Amazon EKS. Automated infrastructure with Terraform (VPC, EKS, ECR) and configured Kubernetes manifests with readiness/liveness probes, ConfigMaps, and Secrets. Implemented ECR-backed image storage, HPA for CPU-based autoscaling, and integrated Prometheus/Grafana (metrics) with Fluent Bit to CloudWatch (logs) for production-grade observability.

---

## Folders
- `app/` — tiny Python HTTP service
- `.github/workflows/` — CI/CD
- `k8s/` — K8s manifests (Deployment/Service/Ingress/HPA)
- `terraform/` — IaC for VPC + EKS + ECR
- `monitoring/` — Helm values for kube-prometheus-stack
- `logging/` — Fluent Bit DaemonSet → CloudWatch

Good luck, and ship it 🚀
