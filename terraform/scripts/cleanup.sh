#!/bin/bash

aws eks --region $REGION update-kubeconfig --name $CLUSTER_NAME

helm uninstall argocd -n argo-cd
helm uninstall external-dns -n external-dns
helm uninstall cert-manager -n cert-manager
helm uninstall nginx-ingress -n nginx-ingress

kubectl delete ingress ingress-host -n apps

kubectl delete svc nginx-service -n apps

kubectl delete deployment nginx-deploy -n apps