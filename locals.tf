
## VPC

locals {
  azs              = ["eu-west-2a", "eu-west-2b"]
  vpc_cidr         = "10.0.0.0/16"
  name             = "eks-cluster"
  region           = "eu-west-2"
  hosted_zones_arn = ["arn:aws:route53::hostedzone/Z0450084SNPHYC3CTRKJ"]


  tags = {
    owner   = "Yossief"
    project = "EKS Project"
  }
}
