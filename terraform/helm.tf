
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  create_namespace = true
  namespace        = "nginx-ingress"

  depends_on = [module.eks]
}


resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  create_namespace = true
  namespace        = "cert-manager"

  set = [{
    name  = "crds.enabled"
    value = "true"
  }]

  values = [
    file("./helm-values/cert-manager.yaml")
  ]

}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "external-dns"

  create_namespace = true
  namespace        = "external-dns"

  set = [
    {
      name  = "wait-for"
      value = module.external_dns_irsa_role.iam_role_arn
    }
  ]

  values = [
    file("./helm-values/external-dns.yaml")
  ]

}

resource "helm_release" "argocd_deploy" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  timeout    = 600
  version    = "7.7.9"

  create_namespace = true
  namespace        = "argo-cd"

  values = [
    file("./helm-values/argo-helm.yaml")
  ]

  depends_on = [helm_release.nginx_ingress, helm_release.cert_manager, helm_release.external_dns]


}