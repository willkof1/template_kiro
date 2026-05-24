# Template hook Kiro

## Template hook default para auxiliar no processo do dia a dia

Torne executável:

```bash
# Git clone

git clone https://github.com/willkof1/template_kiro.git
cp -r template_kiro/kiro_sre_init.sh ~/.local/bin/
chmod +x ~/.local/bin/kiro_sre_init.sh

./kiro_sre_init.sh

# Adicione ao .zshrc se não tiver:

export PATH="$HOME/.local/bin:$PATH"

# Crie o alias

alias kiro_sre_init='kiro_sre_init.sh'
```

## Quando clonar/entrar em um projeto novo

```bash
cd /repos/meu-novo-projeto
kiro_sre_init.sh
```

## Dica para não esquecer
### Adicione isso no seu .zshrc para te lembrar:

```bash
# Verifica se o projeto atual tem hooks do Kiro
kiro-check() {
    if [ -f ".kiro/hooks/sre-auto-commit.kiro.hook" ]; then
        echo "✅ SRE hooks ativos neste projeto"
    else
        echo "⚠️  SRE hooks NÃO instalados. Execute: kiro_sre_init.sh"
    fi
}

# Mostra alerta ao entrar em pastas sem hook
cd() {
    builtin cd "$@"
    if [ -f ".kiro/hooks/sre-auto-commit.kiro.hook" ]; then
        echo -e "\033[32m🔧 SRE Auto-Commit ativo\033[0m"
    elif [ -d ".git" ] && [ ! -f ".kiro/hooks/sre-auto-commit.kiro.hook" ]; then
        echo -e "\033[33m⚠️  Execute 'kiro_sre_init.sh' para ativar auto-commit\033[0m"
    fi
}