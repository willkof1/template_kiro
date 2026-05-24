#!/bin/zsh

# SRE Kiro Bootstrap - Instala hook universal em qualquer projeto

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Template universal (atualize aqui e todos os projetos ganham)
TEMPLATE='{
  "name": "SRE Universal Auto Commit",
  "version": "1.0.0",
  "description": "Auto-commit para Terraform, Kubernetes, GitHub Actions e qualquer IaC",
  "when": {
    "type": "fileEdited",
    "patterns": ["**/*.tf", "**/*.yml", "**/*.yaml", "**/*.tfvars", "**/*.jsonnet", "**/*.conf"]
  },
  "then": {
    "type": "askAgent",
    "prompt": "Execute SRE auto-commit workflow: 1. git add -A. 2. Analise o arquivo editado e detecte o tipo de IaC. 3. Gere conventional commit em ingles (ex: feat(terraform): add module). 4. git commit -m [mensagem]. 5. git push. Regras: Se .tf -> scope terraform, se .yml/.yaml -> scope k8s/ci."
  }
}'

# Verifica se está em um repositório git
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ Erro: Você não está em um repositório git${NC}"
    echo -e "${BLUE}💡 Dica: cd /repos/seu-projeto && kiro_sre_init.sh${NC}"
    exit 1
fi

# Cria estrutura .kiro
mkdir -p .kiro/hooks

# Instala o hook
echo "$TEMPLATE" > .kiro/hooks/sre-auto-commit.kiro.hook

echo -e "${GREEN}✅ Hook SRE instalado com sucesso em:${NC}"
echo -e "${BLUE}   📁 $(pwd)/.kiro/hooks/sre-auto-commit.kiro.hook${NC}"
echo ""
echo -e "${GREEN}🎯 A partir de agora, qualquer arquivo .tf, .yml ou .yaml que você salvar:${NC}"
echo -e "   • git add -A automático"
echo -e "   • Commit semântico gerado por IA"
echo -e "   • Push automático"
echo ""
echo -e "${BLUE}💡 Lembre-se: Você precisa rodar este comando em CADA projeto novo${NC}"
echo -e "${BLUE}   kiro_sre_init.sh${NC}"