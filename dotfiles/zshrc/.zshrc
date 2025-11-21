setopt PROMPT_SUBST
autoload -Uz vcs_info

# Add this to your ~/.zshrc file
alias ls='eza -l --git --header --time-style=long-iso --sort=type'
alias ll='eza -laga --git --header --time-style=long-iso --sort=type'

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

# enable starship
eval "$(starship init zsh)"
