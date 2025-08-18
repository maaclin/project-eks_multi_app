
# EKS Deployment Using Argo CD, Helm and Terraform 🚀

Goal: Deploys a simple portfolio web application to an **Amazon EKS** cluster using **Terraform** for infrastructure, NGINX Ingress for traffic management, **GitHub Actions** and **Argo CD** for CI/CD, **Helm** for app & platform charts. 

--- 

## Contents

- [Architecture](#Architecture)
- [Project Structure](#project-structure)
- [Infrastructure Setup](#infrastructure-setup)
- [How It Works](#how-it-works)
- [Security Considerations](#security-considerations)
- [CI/CD](#CI-CD)
- [Cost Comparison](#Costs)
- [Troubeshooting](#Decisions)

---
## Architecture

![Architecture-diagram](./images/EKS-Project.png)

![Loom video](./images/argoapp.gif)

---

## Project Structure

```
├── .github/workflows
│   ├── apply.yml
│   ├── argo-cd.yaml
│   ├── build.yaml
│   └── destroy.yaml
├── app
│   ├── Dockerfile
│   ├── index.html
│   └── ys2025.pdf
├── argo-cd
│   └── argo-cd.yaml
├── cert-man
│   ├── issuer.yaml
│   └── terraform.tfstate
├── manifests
│   └── deployment.yaml
├── README.md
└── terraform
    ├── helm-values
    │   ├── argo-cd.yaml
    │   ├── cert-manager.yaml
    │   └── external-dns.yaml
    ├── helm.tf
    ├── eks.tf
    ├── irsa.tf
    ├── locals.tf
    ├── Makefile
    ├── providers.tf
    └── vpc.tf
```

## Infrastructure Setup

- State backend: S3 (remote state) with native state locking as AWS moves to deprecate DynamoDB locking.  
- EKS: private node subnets; control plane access as required.
- IRSA: pods assume AWS roles via service account annotations
- Helm: external-dns creates the DNS record in Route 53. cert-manager requests a certificate via the ClusterIssuer from Let's Encrypt and attaches to Ingress → HTTPS.
- ArgoCD: automated deployment of our application 

## Security Considerations

- Scanning in CI before apply: Tflint and Checkov for IaC, Trivy for Docker/K8s
- Rule of least privilege for IRSA roles
- OIDC trust policy used instead of injecting GitHub secrets

## CI-CD  

```
└── workflows
    ├── apply.yml
    ├── argocd.yaml
    ├── build.yaml
    └── destroy.yaml
```

App changes trigger the Docker workflow:
- Build image → push to ECR 

Push to main triggers the Terraform workflow:
- IaC scans (tflint, tfsec, checkov) + trivy config scan
- Terraform init/plan/apply creates/updates VPC, EKS, IRSA, Helm etc.

Terraform destroy:
- Manual workflow trigger to trigger Terraform Destroy

Argo CD:
- Installs Argo CD
- Apply an Argo application that points to our repo so future changes auto-sync.

## Cost Comparison

- EKS control plane hourly charge, node instances, data transfer, Elastic IPs/ALBs if used, Route 53 queries, DNS validation traffic and ECR storage.

- S3 + CloudFront is typically pennies for a small site.

## Troubleshooting

- Ingress not resolving: check external-dns logs; verify hosted zone and domain filters match.

- Certificate pending: check cert-manager Order/Challenge CRDs and that Route 53 records exist; ensure IAM perms via IRSA.

- Argo not syncing: confirm repo URL, path and branch; check Argo Application status and events.

- kubectl auth issues: confirm aws eks update-kubeconfig ran with the right cluster/region/role.