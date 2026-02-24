# Finanfix — Roadmap

> Visão do roadmap por fase. Atualizado conforme issues progridem no Project Board.

---

## Fases

```
Discovery ──→ MVP ──→ Growth ──→ Scale
(validar)    (construir)  (crescer)  (escalar)
```

---

## Discovery — Validar hipóteses e desbloquear dependências

**Objetivo:** Tomar decisões estruturais e resolver dependências externas antes de construir.

| Issue | Título | Agent | Priority | Status |
|-------|--------|-------|----------|--------|
| #4 | Submeter aplicação Belvo produção | Research | P0 | ⛔ Blocked |
| #7 | Avaliar Pluggy como alternativa | Research | P0 | 🧠 Backlog |
| #8 | Decidir pricing tiers finais | Architect | P0 | ⛔ Blocked |
| #10 | Documentar pontos de fricção | Critic | P1 | 🧠 Backlog |

**Critério de saída:** Decisão Open Finance (Belvo vs Pluggy), pricing definido, fricções documentadas.

---

## MVP — Construir o produto mínimo viável

**Objetivo:** Produto funcional end-to-end: signup → bank → score → dashboard → payment.

| Issue | Título | Agent | Priority | Status |
|-------|--------|-------|----------|--------|
| #1 | Daily Digest | Synth | P1 | 🧠 Backlog |
| #2 | GA4 + Meta Pixel | Builder | P1 | 🧠 Backlog |
| #3 | OG tags + SEO | Builder | P1 | 🧠 Backlog |
| #5 | Perfis sociais @finanfix | Founder | P2 | 🧠 Backlog |
| #6 | 8 peças de conteúdo | Founder | P1 | 🧠 Backlog |
| #9 | Concierge onboard beta | Founder | P0 | 🧠 Backlog |
| #11 | Cron recálculo score | Builder | P1 | 🧠 Backlog |
| #12 | Stripe checkout | Builder | P0 | 🧠 Backlog |
| #13 | Google OAuth | Builder | P1 | ⛔ Blocked |
| #14 | Página /pricing | Builder | P1 | 🧠 Backlog |
| #15 | ScoreTrend dashboard | Builder | P1 | 🧠 Backlog |
| #16 | Sanitizar PII (LGPD) | Builder | P0 | 🌙 Tonight |
| #17 | Subscriptions table | Builder | P1 | 🧠 Backlog |
| #18 | Rate limiting | Builder | P1 | 🧠 Backlog |
| #19 | Admin→auth client | Builder | P0 | 🌙 Tonight |
| #21 | KPI snapshot SQL | Builder | P2 | 🧠 Backlog |

**Critério de saída:** 5-10 beta users com score calculado, Stripe checkout live, LGPD compliance básica.

---

## Growth — Escalar aquisição e retenção

**Objetivo:** Aumentar base de usuários e provar retenção.

| Issue | Título | Agent | Priority | Status |
|-------|--------|-------|----------|--------|
| #20 | CSP com nonce | Builder | P2 | 🧠 Backlog |

**Critério de saída:** 100+ usuários, D30 retention > 25%, MRR > R$ 5k.

---

## Scale — Infraestrutura para crescimento

**Objetivo:** Preparar plataforma para escala, multi-entity, parcerias B2B.

_(Sem issues atribuídas nesta fase ainda)_

**Critério de saída:** Multi-entity live, 500+ usuários, infraestrutura auto-scaling.

---

## Prioridades Imediatas

### P0 — Fazer agora
1. **#16** Sanitizar PII (LGPD) — 🌙 Tonight
2. **#19** Admin→auth client — 🌙 Tonight
3. **#12** Stripe checkout — 🧠 Backlog
4. **#9** Concierge onboard — 🧠 Backlog
5. **#4** Belvo produção — ⛔ Blocked (external dep)
6. **#7** Pluggy alternativa — 🧠 Backlog
7. **#8** Pricing tiers — ⛔ Blocked (needs decision)

### Blockers Ativos
- **#4** Belvo — aguardando aprovação da aplicação de produção
- **#8** Pricing — Paulo precisa decidir tiers finais
- **#13** Google OAuth — requer configuração no Google Cloud Console + Supabase Dashboard
