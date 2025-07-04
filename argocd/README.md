# Bootstrap ArgoCD:

### Install latest version via helm:
https://artifacthub.io/packages/helm/argo/argo-cd?modal=install
```
helm repo add argo https://argoproj.github.io/argo-helm
helm install --create-namespace -n argocd argocd argo/argo-cd --version 8.1.0
```

### Install ArgoCD CLI
https://argo-cd.readthedocs.io/en/stable/cli_installation/

## Login to ArgoCD
```
argocd login <ARGOCD_SERVER> --username admin --password <ARGOCD_PASSWORD>
```

### Add repo
argocd repo add https://github.com/devopsjourney1/talos-homelab.git

### Bootstrap App of Apps

argocd app create apps \
    --dest-namespace argocd \
    --dest-server https://kubernetes.default.svc \
    --repo https://github.com/devopsjourney1/talos-homelab.git \
    --path argocd/apps


## Change password
```
argocd account update-password --account <new-account-name> --current-password <admin-password> --new-password <new-account-password>
```