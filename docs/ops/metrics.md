# Finanfix — Métricas Operacionais

> Métricas de processo acompanhadas pelo CEO Cockpit.

---

## Métricas de Fluxo

### Throughput (Vazão)
- **Definição:** Issues movidas para ✅ Done por semana
- **Target:** 3-5/semana (fase MVP)
- **Fonte:** Daily Digest automático + contagem manual no board
- **Ação se abaixo:** Verificar se há Blocked acumulando ou escopo inflado

### WIP (Work in Progress)
- **Definição:** Issues em ⚙️ Running + 🔍 Review simultaneamente
- **Target:** ≤ 3 (princípio de foco)
- **Fonte:** Kanban Principal
- **Ação se acima:** Terminar antes de começar. Mover excesso de volta para Backlog.

### Cycle Time
- **Definição:** Tempo médio de 🌙 Tonight → ✅ Done
- **Target:** < 3 dias para Code, < 1 dia para Ops
- **Fonte:** Estimado via datas de movimentação
- **Ação se alto:** Quebrar issues grandes em sub-tasks

### Lead Time
- **Definição:** Tempo de 🧠 Backlog → ✅ Done
- **Target:** < 2 semanas
- **Fonte:** Data de criação vs data de Done

---

## Métricas de Saúde

### Blocked Rate
- **Definição:** % de issues abertas em ⛔ Blocked
- **Target:** < 15%
- **Ação se alto:** Sessão de desbloqueio — decisões, contatos com terceiros

### Tonight Queue Size
- **Definição:** Número de issues em 🌙 Tonight
- **Target:** 1-3 (capacidade noturna dos agentes)
- **Ação se vazio:** Priorizar próximas P0/P1 do Backlog

### Agent Distribution
- **Definição:** Issues por Agent (distribuição de carga)
- **Target:** Builder não deve ter > 60% do WIP
- **Ação se desbalanceado:** Redistribuir ou paralelar com Research/Critic

---

## Métricas por Domínio

Cada domínio tem métricas de produto específicas documentadas em:
- [KPI Dashboard](../kpi-dashboard.md) — valores atuais vs targets
- [PM Domains](../pm-domains.md) — métricas por domínio com roadmap

---

## Cadência de Acompanhamento

| Frequência | O quê | Como |
|------------|-------|------|
| Diária (auto) | Throughput 24h, blockers, tonight queue | Daily Digest (Issue #1) |
| Semanal | KPIs de produto, throughput semanal | Atualizar kpi-dashboard.md |
| Quinzenal | Cycle time, blocked rate, agent distribution | Review manual do board |
| Mensal | Roadmap phase progress, MRR, retenção | Sessão estratégica |
