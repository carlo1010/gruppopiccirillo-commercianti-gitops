# Platform Control Plane

Questa cartella contiene i manifest del `tenant-server` eseguito dentro K3s.

## Prerequisiti

- creare il secret `tenant-server-secrets` nel namespace `platform`
- creare un record DNS `A` per `platform.commercianti.carloiodice.it`
- pubblicare l'immagine `ghcr.io/carlo1010/gruppopiccirillo-commercianti-tenant-server:main`

## Secret richiesto

Nel namespace `platform` il deployment si aspetta il secret `tenant-server-secrets` con:

- `TENANT_ADMIN_CLIENTS_JSON`
- `TENANT_RELEASE_SIGNING_SECRET`
- `GITOPS_PUSH_TOKEN`

## Flusso

Il pod:

1. clona il repo GitOps in un volume temporaneo
2. esegue il control plane
3. genera desired state tenant e GitOps
4. commit e push automatico verso GitHub quando `GITOPS_REMOTE_SYNC_ENABLED=true`
