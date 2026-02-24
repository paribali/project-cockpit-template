# Finanfix — Labels

> Referência completa dos labels usados no repositório e project board.

---

## Domínio

Identifica qual área de produto a issue pertence.

| Label | Cor | Domínio |
|-------|-----|---------|
| `domain:acquisition` | 🟢 | PM1: Aquisição — SEO, social, landing, ads, lead capture |
| `domain:core` | 🔵 | PM2: Produto Core — Onboarding, Open Finance, scoring, dashboard |
| `domain:monetization` | 🟡 | PM3: Monetização — Pricing, Stripe, subscriptions, feature gating |
| `domain:retention` | 🟣 | PM4: Retenção — WhatsApp, notificações, trends, engajamento |
| `domain:platform` | ⚪ | PM5: Plataforma — Segurança, infra, LGPD, CI/CD, performance |

---

## Tipo

Classifica o tipo de trabalho.

| Label | Descrição |
|-------|-----------|
| `type:feature` | Nova funcionalidade |
| `type:bug` | Correção de bug |
| `type:experiment` | Teste/validação de hipótese |
| `type:metric-alert` | Métrica fora do target |
| `type:infra` | Infraestrutura, DevOps, CI/CD |
| `type:content` | Conteúdo, copy, social media |
| `type:debt` | Débito técnico |

---

## Prioridade

| Label | Significado |
|-------|-------------|
| `P0-critical` | Bloqueia receita ou produção. Resolver imediatamente. |
| `P1-high` | Importante para o sprint atual. |
| `P2-medium` | Planejado mas não urgente. |
| `P3-low` | Nice-to-have, backlog de longo prazo. |

---

## Status (issue labels)

Labels de status complementam o campo Status do Project. Usados para filtros e automações.

| Label | Significado |
|-------|-------------|
| `status:blocked` | Bloqueada — impedimento técnico ou de processo |
| `status:needs-decision` | Aguarda decisão do founder (Paulo) |
| `status:needs-murilo` | Aguarda input/ação do Murilo (tributário) |
| `status:external-dep` | Depende de terceiro (Belvo, Google, Stripe, etc.) |

---

## Outros

| Label | Uso |
|-------|-----|
| `documentation` | Documentação, guides, READMEs |
| `good first issue` | Boa para onboarding de contribuidores |
| `enhancement` | Melhoria em feature existente |

---

## Convenções

1. **Toda issue deve ter:** pelo menos 1 `domain:*` + 1 `P*` + 1 `type:*`
2. **Issues bloqueadas** devem ter `status:blocked` E/OU `status:external-dep` + comentário explicando o motivo
3. **Decisões pendentes** recebem `status:needs-decision` e ficam como ⛔ Blocked no project
4. **Labels não substituem campos do Project** — são complementares para filtros e automações
