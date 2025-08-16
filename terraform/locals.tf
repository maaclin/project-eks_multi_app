
## VPC

locals {
  azs              = ["eu-west-2a", "eu-west-2b"]
  vpc_cidr         = "10.0.0.0/16"
  name             = "eks-cluster"
  hosted_zones_arn = "arn:aws:route53:::hostedzone/Z06820233RGKWT7NAQ14I"


  tags = {
    owner   = "Yossief"
    project = "EKS Project"
  }
}
