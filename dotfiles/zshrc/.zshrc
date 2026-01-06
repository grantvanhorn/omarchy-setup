setopt PROMPT_SUBST
autoload -Uz vcs_info

# zinit manual installation
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add this to your ~/.zshrc file
alias ls='eza -l --git --header --time-style=long-iso --sort=type'
alias ll='eza -laga --git --header --time-style=long-iso --sort=type'
alias zsource="source ~/.zshrc"

# Setup history
HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000

# Prompt setup
function precmd() {
   vcs_info
}

zstyle ':vcs_info:git:*' formats '%F{125}[ %b] '
PROMPT='%F{129} %c %f$vcs_info_msg_0_%F{129}»%f '
RPROMPT='%F{129}[%F{129}%F{125}%D{%L:%M:%S}%F{125}%F{129}]%F{129}'$RPROMPT

# Promp Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# nvm
export NVM_DIR="$HOME/.config/nvm"
set -h
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
set +h

# Auto-switch Node version based on .nvmrc
load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light agkozak/zsh-z

# Syntax highlighting colors (set after plugin loads)
ZSH_HIGHLIGHT_STYLES[command]='fg=#00FF00,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#00FFFF,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#00FF00,bold'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#00FF00,bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF0000,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#FF00FF,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#FF00FF,bold'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#00FFFF,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#00FFFF,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#04C5F0'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#04C5F0'
ZSH_HIGHLIGHT_STYLES[path]='fg=#ff7f41,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#00FFFF,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#ffbe74,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#ffbe74,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#FFFFFF,bold'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#FFFFFF,bold'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#FFFFFF'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#888888'

# enable starship
eval "$(starship init zsh)"
