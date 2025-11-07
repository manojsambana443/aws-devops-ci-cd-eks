#  AWS DevOps Project — GitHub Actions → ECR → EKS  
### Infrastructure as Code • CI/CD • Kubernetes • HPA • Observability  
**By Manoj**

---

## Why I Built This Project
While learning DevOps, I wanted to go beyond simple Docker projects and build something that represents how **real teams deploy applications** in production.  
So this project covers the **full DevOps lifecycle**:

- Code → Build → Test → Containerize → Deploy → Monitor
- Automated CI/CD (No manual deployments)
- Infrastructure created using Terraform (No AWS console clicking)
- Scalable application deployment using Kubernetes and HPA
- Centralized logging and real monitoring dashboards

The goal was to **think and work like a DevOps Engineer**, not just practice commands.

---

## High-Level Workflow (In My Words)




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

##  Key Design Decisions & Why They Matter

| Component | Why I Used It |
|----------|---------------|
| **Terraform** | To automate AWS infrastructure creation, so everything is reproducible. |
| **GitHub Actions + OIDC** | Secure CI/CD → avoids storing AWS Access Keys. |
| **Amazon ECR** | Private container registry integrated with AWS IAM. |
| **EKS (Kubernetes)** | Real orchestration platform with scaling & rolling updates. |
| **HPA (Horizontal Pod Autoscaler)** | Automatically scales pods based on CPU usage. |
| **Prometheus + Grafana** | Real-time monitoring + dashboards to view cluster and app performance. |
| **Fluent Bit → CloudWatch** | Unified log storage for debugging and tracing. |

---

## What You Need to Change (Search & Replace)

| Placeholder | Replace With |
|------------|--------------|
| `ap-south-1` | Your AWS region |
| `154980000474` | Your AWS account ID |
| `demo-eks` | Your EKS cluster name |
| `github-oidc-deploy-role` | IAM role for GitHub Actions |
| `demo-web` | App name / image tag |

---

## Deploying the Infrastructure
```bash
cd terraform
terraform init
terraform apply -var='aws_region=ap-south-1' -auto-approve


Terraform outputs your ECR Repository & EKS kubeconfig update command.
---


## 🐳 Local Test (Before Cloud Deploy)

Before deploying, I verified that the application works locally:

```bash
docker build -t demo-web:local .
docker run -p 8080:8080 demo-web:local
curl http://localhost:8080

---


## CI/CD Pipeline Summary (My Explanation)

Whenever I push code to the **main** branch:

1. GitHub Actions builds the Docker image.
2. The image is tagged using the Git commit SHA.
3. The image is pushed to **Amazon ECR**.
4. The Kubernetes Deployment manifest is updated with the new image.
5. The application is redeployed automatically to **Amazon EKS**.

This removes the need for manual `kubectl` commands.  
Deployments are now **automated, consistent, and traceable**.

---

## 📊 Observability & Logging

| Feature | Tool | Purpose |
|--------|------|---------|
| Metrics & Dashboards | **Prometheus + Grafana** | Monitor CPU usage, pod scaling, and latency |
| Logging | **Fluent Bit → CloudWatch Logs** | Centralized log storage for debugging and audits |

---

## 📁 Project Structure

- `app/` — tiny Python HTTP service
- `.github/workflows/` — CI/CD
- `k8s/` — K8s manifests (Deployment/Service/Ingress/HPA)
- `terraform/` — IaC for VPC + EKS + ECR
- `monitoring/` — Helm values for kube-prometheus-stack
- `logging/` — Fluent Bit DaemonSet → CloudWatch

---

## ✅ What I Learned

- How to deploy applications in a **cloud-native, scalable** manner
- How **CI/CD pipelines** improve software delivery and reduce manual work
- How **Kubernetes HPA** handles real workload-based scaling
- Why **monitoring and logging** are crucial in real production environments
- How to think and work like a **DevOps Engineer**, not just follow tutorials

