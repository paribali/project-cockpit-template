# Finanfix — CEO Cockpit

> Guia operacional para uso do GitHub Project como cockpit de gestão.

---

## Visão Geral

O cockpit centraliza toda gestão do Finanfix em um GitHub Project V2 com campos customizados que permitem visibilidade instantânea de:

- **O que está acontecendo** (Status)
- **Quem está fazendo** (Agent)
- **Que tipo de trabalho** (Type)
- **Em que fase do roadmap** (Roadmap Phase)
- **Qual a prioridade** (Priority)
- **Quando está pronto** (Definition of Done)

**URL:** https://github.com/orgs/paribali/projects/2

---

## Campos do Project

### Status (fluxo de trabalho)

| Status | Significado | Quem move |
|--------|------------|-----------|
| 🚀 Roadmap | Épicos e objetivos de alto nível | Paulo |
| 🧠 Backlog | Planejadas, prontas para priorizar | Paulo / Agent |
| 🌙 Tonight | Fila de execução noturna (agentes IA) | Paulo |
| ⚙️ Running | Em processamento ativo | Agent |
| 🔍 Review | Aguardando revisão humana | Agent → Paulo |
| ✅ Done | Concluída e verificada | Paulo |
| ⛔ Blocked | Bloqueada por dependência externa ou decisão | Qualquer |

**Fluxo típico:** Backlog → Tonight → Running → Review → Done

### Agent (quem executa)

| Agent | Papel |
|-------|-------|
| Research | Pesquisa, análise de mercado, avaliação de alternativas |
| Architect | Decisões de design, arquitetura, pricing |
| Builder | Implementação de código, infraestrutura |
| Critic | Revisão, pontos de fricção, QA |
| Synth | Relatórios, sínteses, daily digest |

Issues sem Agent são responsabilidade direta do founder (Paulo/Murilo).

### Type (tipo de trabalho)

| Type | Exemplos |
|------|----------|
| Strategy | Pricing, decisões de produto, parcerias |
| Research | Avaliação de APIs, análise competitiva |
| Copy | Conteúdo, social media, textos |
| Code | Features, bug fixes, infraestrutura |
| Design | UI/UX, landing page |
| Ops | Automações, dashboards, processos |

### Roadmap Phase

| Fase | Descrição |
|------|-----------|
| Discovery | Validação de hipóteses, pesquisa, decisões pendentes |
| MVP | Construção do produto mínimo viável |
| Growth | Escala de aquisição e retenção |
| Scale | Infraestrutura para crescimento |

### Priority

| Prioridade | Critério |
|------------|----------|
| P0 | Bloqueia receita ou produção. Fazer primeiro. |
| P1 | Importante para o sprint atual. Fazer esta semana. |
| P2 | Nice-to-have. Fazer quando P0/P1 estiverem limpos. |

---

## Views Recomendadas

### 1. Kanban Principal (Board)
- **Layout:** Board
- **Group by:** Status
- **Uso:** Visão diária do fluxo de trabalho

### 2. Roadmap (Table)
- **Layout:** Table
- **Group by:** Roadmap Phase
- **Uso:** Visão estratégica por fase

### 3. Agent Dashboard (Table)
- **Layout:** Table
- **Group by:** Agent
- **Uso:** O que cada agente está fazendo

### 4. Blocked & Risks (Table)
- **Layout:** Table
- **Filter:** Status = "⛔ Blocked"
- **Uso:** Identificar e resolver bloqueios

---

## Rotina Diária (< 2 min)

1. **Abrir o Kanban Principal** → ver o que está Running, Tonight, Blocked
2. **Ler o Daily Digest** → Issue #1, último comentário
3. **Mover issues para Tonight** se há agentes disponíveis
4. **Resolver Blocked** → tomar decisões, contatar dependências externas
5. **Verificar Review** → aprovar ou pedir ajustes

---

## Daily Digest Automático

O workflow `.github/workflows/daily-digest.yml` roda todo dia útil às 06:00 BRT e posta um comentário na Issue #1 com:

- Contagem por status, agent e domain
- Issues movidas nas últimas 24h
- Blockers ativos com motivo
- Tonight queue (próxima execução)
- Commits e PRs das últimas 24h
- Decisões pendentes
- Métricas: throughput, WIP, cycle time

Pode ser disparado manualmente via `workflow_dispatch`.

---

## Referências

- [Labels](./labels.md) — Lista completa de labels
- [Métricas](./metrics.md) — Métricas acompanhadas
- [Roadmap](../roadmap/roadmap.md) — Visão por fase
- [KPI Dashboard](../kpi-dashboard.md) — Métricas de produto
- [PM Domains](../pm-domains.md) — Estrutura de domínios
