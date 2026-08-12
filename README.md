# Vela Foundation demo apps

Five different applications generated from [vela-foundation](https://github.com/novaoc/vela-foundation).

| App | Type | Port | Path |
|-----|------|------|------|
| **Lumen Market** | Digital storefront | 3001 | `lumen-market/` |
| **Northstar CRM** | Sales CRM | 3002 | `northstar-crm/` |
| **Nebula Quest** | Browser arcade game | 3003 | `nebula-quest/` |
| **PokeVault** | Pokemon card portfolio tracker | 3004 | `pokevault/` |
| **Echo Chat** | Support chatbot + agent inbox | 3005 | `echo-chat/` |

## Prerequisites

- Ruby 4.0.5 (see each app `.ruby-version`)
- PostgreSQL 16 (`localhost:5432`, user/password `postgres`/`postgres` or peer auth)
- libpq for the `pg` gem

## Setup

```bash
# start postgres (docker example)
docker start vf-pg || docker run -d --name vf-pg -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres:16-alpine

./bin/setup-all
./bin/start-all
```

Open the ports above. Preview-friendly local boot uses development defaults; storefront checkout uses the local simulator when Stripe is unset in development.

## Module choices

- Lumen Market: storefront on, CRM omitted
- Northstar CRM: CRM on, storefront omitted
- Nebula Quest / PokeVault / Echo Chat: both optional modules omitted; custom product code added
