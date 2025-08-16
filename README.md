
# EKS Deployment Using Argo CD, Helm and Terraform 🚀

--- 

Goal: Deploys a simple portfolio web application to an **Amazon EKS** cluster using **Terraform** for infrastructure, **GitHub Actions** for CI/CD, **Helm** for app & platform charts, and **Argo CD** for GitOps bootstrapping. 

Note: This is intentionally more complex than needed for a static site (which fits S3 + CloudFront perfectly)

--- 

## Contents

- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Infrastructure Setup](#infrastructure-setup)
- [Security & Governance](#security--governance)
- [CI/CD Workflows](#cicd-workflows)
- [How It Works (End-to-End Flow)](#how-it-works-end-to-end-flow)
- [Notes & Decisions](#notes--decisions)
- [EKS vs S3+CloudFront](#eks-vs-s3cloudfront)
- [Costs](#costs)
- [Cleanup](#cleanup)
- [Troubleshooting](#troubleshooting)
- [License](#license)

---
## Architecture





---

## Project Structure

```
├── app
│   ├── Dockerfile
│   ├── images
│   │   └── portfolio.png
│   ├── index.html
│   └── ys2025.pdf
├── cert-man
│   └── issuer.yaml
├── manifests
│   └── deployment.yaml
├── README.md
└── terraform
    ├── eks.tf
    ├── helm-values
    │   ├── argo-cd.yaml
    │   ├── cert-manager.yaml
    │   └── external-dns.yaml
    ├── helm.tf
    ├── irsa.tf
    ├── locals.tf
    ├── Makefile
    ├── providers.tf
    └── vpc.tf
```

vpc module
eks module 
irsa module
helm module 

terraform apply 

helm chart creation for 
- external-dns
- cert-manager

