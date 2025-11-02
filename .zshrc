# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

# Colored man page using less
export GROFF_NO_SGR=1

# zsh-autosuggestions color dark grey
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#a9a9a9"

# Alias
alias c=clear
alias rb="source ~/.zshrc"
alias path='echo -e ${PATH//:/\\n}'
alias nv="nvim"
alias l='eza --color=always --color-scale=all --color-scale-mode=fixed --icons=never --group-directories-first -l --git -h --time-style=long-iso'
alias ll='eza --color=always --color-scale=all --color-scale-mode=fixed --icons=never --group-directories-first -a -l --git -h --time-style=long-iso'
alias lg='lazygit'


# thefuck - https://github.com/nvbn/thefuck?tab=readme-ov-file#manual-installation
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# Brew auto-update frequency (12 days)
export HOMEBREW_AUTO_UPDATE_SECS=1036800

# tmux ssh agent stale socket fix (only when inside tmux)
if [ -n "$TMUX" ]; then
    eval "$(tmux show-env -s | grep '^SSH_')" 2>/dev/null
fi

# SSH agent management: start a user agent only if current one is unusable or is launchd (macos only) socket
is_macos_launchd_socket() {
  [ -n "$SSH_AUTH_SOCK" ] && [[ "$SSH_AUTH_SOCK" == /private/tmp/com.apple.launchd.*/* ]]
}

agent_works() { ssh-add -l >/dev/null 2>&1; }

start_user_agent() {
  eval "$(ssh-agent -s)" >/dev/null
  ssh-add -l >/dev/null 2>&1 || ssh-add ~/.ssh/personal >/dev/null 2>&1
}

if ! agent_works; then
  if is_macos_launchd_socket || [ -z "$SSH_AUTH_SOCK" ]; then
    start_user_agent
  fi
fi


# kubectl auto-completion
source <(kubectl completion zsh)

# Helm auto-completion
source <(helm completion zsh)

# fzf
source <(fzf --zsh)

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Enable k9s node shell
export K9S_FEATURE_GATE_NODE_SHELL=true

# Plugins
plugins=()
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(zoxide init --cmd cd zsh)"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/kevinhmchan/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions


# fzf-tab after `compinit`
source ~/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh
