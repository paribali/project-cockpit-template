# CEO Cockpit Template

Template reutilizável para configurar um cockpit de gestão com GitHub Projects V2, agentes autônomos noturnos, e daily digest com sugestões de ação.

## O que inclui

### GitHub Project V2
- **7 status**: Roadmap, Backlog, Tonight, Running, Review, Done, Blocked
- **6 campos customizados**: Agent, Type, Roadmap Phase, Priority, Definition of Done, Output Link
- **Labels padronizados**: domain:*, type:*, P0-P3, status:*

### Workflows
- **Daily Digest** (06:00 BRT) — relatório diário com sugestões de ação, foco do dia, e recomendação de tonight queue
- **Nightly Agent** (22:00 BRT) — executa issues do Tonight queue com Claude Code, cria PRs, atualiza board

### Dashboard Visual (Next.js)
- Página `/ops/cockpit` com auto-refresh
- API `/api/v1/ops/github` para dados do project
- Dark theme, stat cards, kanban, agent distribution

### Documentação
- `docs/ops/cockpit.md` — guia operacional
- `docs/ops/labels.md` — referência de labels
- `docs/ops/metrics.md` — métricas de fluxo
- `docs/roadmap/roadmap.md` — template de roadmap por fase

## Setup Rápido

```bash
# 1. Rodar o script de setup
./scripts/setup-cockpit.sh <owner> <repo>

# 2. Copiar workflows para o repo
cp .github/workflows/*.yml <seu-repo>/.github/workflows/

# 3. Configurar secrets
gh secret set ANTHROPIC_API_KEY --repo <owner>/<repo>
gh secret set GH_PAT --repo <owner>/<repo>

# 4. Criar views manualmente no GitHub Project
#    (API não suporta criação de views)
```

## Secrets Necessários

| Secret | Onde | Para quê |
|--------|------|----------|
| `ANTHROPIC_API_KEY` | GitHub Actions | Claude Code Action |
| `GH_PAT` | GitHub Actions | Acesso ao Project V2 |
| `GITHUB_TOKEN` | Vercel (se usar dashboard) | API do dashboard |

## Fluxo de Trabalho

```
Backlog → Tonight → Running → Review → Done
                                 ↓
                              Blocked
```

1. **Paulo move issues para Tonight** no board
2. **Nightly Agent roda às 22:00** — processa Tonight, cria PRs
3. **Daily Digest às 06:00** — relatório com sugestões
4. **Paulo revisa PRs** e move para Done

## Adaptação por Projeto

Para usar em um novo projeto, edite:

1. `nightly-agent.yml` — atualizar `PROJECT_ID`, `STATUS_FIELD_ID`, e option IDs
2. `daily-digest.yml` — atualizar `PROJECT_NUMBER` se diferente
3. `docs/roadmap/roadmap.md` — adaptar fases e issues
4. Labels — adicionar domínios específicos do projeto

## Criado por

Paribali Consulting — Strategic Architecture for Digital & Financial Systems
