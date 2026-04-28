# GitOps Bootstrap

Questa cartella contiene la desired state GitOps della platform multi-tenant.

## Struttura

- `argocd/bootstrap-application.yaml`: application Argo CD che sincronizza il bootstrap cluster-scoped
- `argocd/project.yaml`: `AppProject` Argo CD per tenant platform
- `bootstrap/platform-application.yaml`: application Argo CD che sincronizza il control plane in namespace `platform`
- `argocd/tenants-root-application.yaml`: root application che sincronizza le `Application` tenant
- `bootstrap/letsencrypt-prod.yaml`: `ClusterIssuer` Let’s Encrypt usato dai tenant
- `platform/tenant-server/`: manifest del control plane eseguito in K3s
- `tenants/<slug>/tenant.json`: snapshot del contratto tenant
- `tenants/<slug>/values.json`: values Helm generati dal control plane
- `tenants/<slug>/application.yaml`: `Application` Argo CD del tenant
- `tenants/<slug>/releases.json`: storico release noto al control plane

## Nota

Il bootstrap cluster-scoped viene gestito da `argocd/bootstrap-application.yaml` e deve essere applicato una volta sola in Argo CD.
La cartella `tenants/` viene popolata dal `tenant-server` durante create, update, deploy e delete del tenant.
