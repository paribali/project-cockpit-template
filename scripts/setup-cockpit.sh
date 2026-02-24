#!/bin/bash
# ============================================================================
# CEO Cockpit — Project Setup Script
# ============================================================================
# Creates a GitHub Project V2 with CEO Cockpit structure for any repository.
#
# Usage:
#   ./setup-cockpit.sh <owner> <repo>
#
# Example:
#   ./setup-cockpit.sh paribali nova-empresa
#
# Prerequisites:
#   - gh CLI authenticated with scopes: repo, project, read:org, workflow
#   - Repository must exist on GitHub
# ============================================================================

set -euo pipefail

OWNER="${1:?Usage: $0 <owner> <repo>}"
REPO="${2:?Usage: $0 <owner> <repo>}"

echo "=== CEO Cockpit Setup ==="
echo "Owner: $OWNER"
echo "Repo:  $REPO"
echo ""

# ---- 1. Create Project ----
echo "[1/7] Creating GitHub Project..."
PROJECT_URL=$(gh project create --owner "$OWNER" --title "${REPO} PM" --format json --jq '.url' 2>/dev/null || echo "")
if [ -z "$PROJECT_URL" ]; then
  echo "  Project may already exist. Listing..."
  PROJECT_NUM=$(gh project list --owner "$OWNER" --format json --jq ".projects[] | select(.title == \"${REPO} PM\") | .number" 2>/dev/null || echo "")
  if [ -z "$PROJECT_NUM" ]; then
    echo "  Creating new project..."
    gh project create --owner "$OWNER" --title "${REPO} PM"
    PROJECT_NUM=$(gh project list --owner "$OWNER" --format json --jq ".projects[] | select(.title == \"${REPO} PM\") | .number")
  fi
else
  PROJECT_NUM=$(echo "$PROJECT_URL" | grep -oP '\d+$')
fi
echo "  Project number: $PROJECT_NUM"

# ---- 2. Get Project ID and Status Field ----
echo "[2/7] Getting project metadata..."
PROJECT_META=$(gh api graphql -f query="
  query {
    user(login: \"$OWNER\") {
      projectV2(number: $PROJECT_NUM) {
        id
        field(name: \"Status\") {
          ... on ProjectV2SingleSelectField {
            id
            options { id name }
          }
        }
      }
    }
  }
")
PROJECT_ID=$(echo "$PROJECT_META" | python3 -c "import sys,json; print(json.load(sys.stdin)['data']['user']['projectV2']['id'])")
STATUS_FIELD_ID=$(echo "$PROJECT_META" | python3 -c "import sys,json; print(json.load(sys.stdin)['data']['user']['projectV2']['field']['id'])")
echo "  Project ID: $PROJECT_ID"
echo "  Status Field: $STATUS_FIELD_ID"

# ---- 3. Update Status Options ----
echo "[3/7] Configuring status options..."
EXISTING_OPTIONS=$(echo "$PROJECT_META" | python3 -c "
import sys,json
opts = json.load(sys.stdin)['data']['user']['projectV2']['field']['options']
for o in opts:
    print(o['name'])
")

DESIRED_STATUSES=("🚀 Roadmap" "🧠 Backlog" "🌙 Tonight" "⚙️ Running" "🔍 Review" "✅ Done" "⛔ Blocked")

for status in "${DESIRED_STATUSES[@]}"; do
  if echo "$EXISTING_OPTIONS" | grep -qF "$status"; then
    echo "  ✓ $status (exists)"
  else
    echo "  + Creating: $status"
    gh api graphql -f query="
      mutation {
        updateProjectV2(input: {
          projectId: \"$PROJECT_ID\"
          title: \"${REPO} PM\"
        }) { projectV2 { id } }
      }
    " > /dev/null 2>&1 || true
  fi
done

# ---- 4. Create Custom Fields ----
echo "[4/7] Creating custom fields..."

create_field() {
  local name="$1"
  local type="$2"
  local options="$3"

  if [ "$type" = "SINGLE_SELECT" ]; then
    gh project field-create "$PROJECT_NUM" --owner "$OWNER" --name "$name" --data-type SINGLE_SELECT --single-select-options "$options" 2>/dev/null && echo "  + $name" || echo "  ✓ $name (exists)"
  else
    gh project field-create "$PROJECT_NUM" --owner "$OWNER" --name "$name" --data-type TEXT 2>/dev/null && echo "  + $name" || echo "  ✓ $name (exists)"
  fi
}

create_field "Agent" "SINGLE_SELECT" "Research,Architect,Builder,Critic,Synth"
create_field "Type" "SINGLE_SELECT" "Strategy,Research,Copy,Code,Design,Ops"
create_field "Roadmap Phase" "SINGLE_SELECT" "Discovery,MVP,Growth,Scale"
create_field "Priority" "SINGLE_SELECT" "P0,P1,P2"
create_field "Definition of Done" "TEXT" ""
create_field "Output Link" "TEXT" ""

# ---- 5. Create Labels ----
echo "[5/7] Creating labels..."

create_label() {
  gh label create "$1" --color "$2" --description "$3" --repo "$OWNER/$REPO" 2>/dev/null && echo "  + $1" || echo "  ✓ $1 (exists)"
}

# Domain labels
create_label "domain:acquisition" "0E8A16" "PM1: Aquisição"
create_label "domain:core" "1D76DB" "PM2: Produto Core"
create_label "domain:monetization" "FBCA04" "PM3: Monetização"
create_label "domain:retention" "7057FF" "PM4: Retenção"
create_label "domain:platform" "CCCCCC" "PM5: Plataforma"

# Type labels
create_label "type:feature" "A2EEEF" "Nova funcionalidade"
create_label "type:bug" "D73A4A" "Correção de bug"
create_label "type:experiment" "F9D0C4" "Teste/validação de hipótese"
create_label "type:infra" "BFD4F2" "Infraestrutura, DevOps"
create_label "type:content" "BFDADC" "Conteúdo, copy"
create_label "type:debt" "E4E669" "Débito técnico"

# Priority labels
create_label "P0-critical" "B60205" "Bloqueia receita ou produção"
create_label "P1-high" "D93F0B" "Importante para sprint atual"
create_label "P2-medium" "FBCA04" "Planejado mas não urgente"
create_label "P3-low" "0E8A16" "Nice-to-have"

# Status labels
create_label "status:blocked" "B60205" "Bloqueada"
create_label "status:needs-decision" "D93F0B" "Aguarda decisão do founder"
create_label "status:external-dep" "FBCA04" "Depende de terceiro"

# ---- 6. Create Daily Digest Issue ----
echo "[6/7] Creating Daily Digest issue..."
EXISTING=$(gh issue list --repo "$OWNER/$REPO" --search "Daily Digest" --json number --jq '.[0].number' 2>/dev/null || echo "")
if [ -z "$EXISTING" ]; then
  gh issue create --repo "$OWNER/$REPO" \
    --title "CEO Cockpit — Daily Digest" \
    --body "Issue pinada para receber CEO Cockpit reports diários.

Cada dia útil às 06:00 BRT, um comment é adicionado com o resumo completo.

## O que inclui
- Board summary (status, agents, priorities)
- Tonight queue
- Blockers ativos
- Decisões pendentes
- Commits & PRs (24h)
- Ações sugeridas para o dia
- Foco do dia
- Recomendação para tonight" \
    --label "documentation"
  echo "  + Created Daily Digest issue"
else
  echo "  ✓ Daily Digest issue exists (#$EXISTING)"
fi

# ---- 7. Setup Secrets Reminder ----
echo "[7/7] Checking secrets..."
echo ""
echo "=== SETUP COMPLETE ==="
echo ""
echo "Next steps (manual):"
echo ""
echo "1. Copy workflow files to your repo:"
echo "   cp .github/workflows/daily-digest.yml <your-repo>/.github/workflows/"
echo "   cp .github/workflows/nightly-agent.yml <your-repo>/.github/workflows/"
echo ""
echo "2. Update PROJECT_ID and field IDs in nightly-agent.yml:"
echo "   PROJECT_ID: $PROJECT_ID"
echo "   STATUS_FIELD_ID: $STATUS_FIELD_ID"
echo ""
echo "3. Set GitHub Actions secrets:"
echo "   gh secret set ANTHROPIC_API_KEY --repo $OWNER/$REPO"
echo "   gh secret set GH_PAT --repo $OWNER/$REPO"
echo ""
echo "4. If using CEO Cockpit dashboard (Next.js):"
echo "   - Copy src/app/ops/ and src/app/api/v1/ops/ to your project"
echo "   - Add GITHUB_TOKEN to Vercel env vars"
echo "   - Add /ops to public routes in middleware"
echo ""
echo "5. Create views in GitHub Project (manual):"
echo "   - Kanban Principal: Board, Group by Status"
echo "   - Roadmap: Table, Group by Roadmap Phase"
echo "   - Agent Dashboard: Table, Group by Agent"
echo "   - Blocked & Risks: Table, Filter Status = Blocked"
echo ""
echo "Project URL: https://github.com/users/$OWNER/projects/$PROJECT_NUM"
