# ENV
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"
export KUBE_EDITOR="nvim"
export MANPAGER='nvim +Man!'
export GPG_TTY=$(tty)
export NVM_DIR="$HOME/.nvm"
export HOMEBREW_AUTO_UPDATE_SECS=1036800

# TOOL SETTINGS
export BAT_THEME="Catppuccin Mocha"
export K9S_SKIN="catppuccin-mocha"
export K9S_FEATURE_GATE_NODE_SHELL=true
export FZF_COMPLETION_OPTS='--multi'
export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# HOMEBREW
eval "$(brew shellenv)"
fpath=($HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
[[ -d "$HOME/.docker/completions" ]] && fpath=("$HOME/.docker/completions" $fpath)

# OH MY ZSH
plugins=(git) # Add only essential plugins here
source $ZSH/oh-my-zsh.sh

# ALIASES
alias c='clear'
alias rb='source ~/.zshrc'
alias path='echo -e ${PATH//:/\\n}'
alias nv='nvim'
alias fc='fc -e nvim'
alias l='eza --color=always --color-scale=all --icons=never --group-directories-first -l --git -h --time-style=long-iso'
alias ll='l -a'
alias pw='pwgen -cs 10 1 | tr -d "\n" | pbcopy'
alias lg='lazygit'
alias lzd='lazydocker'
alias gl='git log --all --oneline --graph --decorate --color=always'
alias gbf="git branch --format='%(refname:short)' | fzf --preview 'git log --oneline --graph --decorate --color=always {} | head -20'"
alias j='just'
alias jg='just -g'
alias k='kubectl'

# SSH AGENT FIXES
if [ -n "$TMUX" ]; then eval "$(tmux show-env -s | grep '^SSH_')" 2>/dev/null; fi

is_macos_launchd_socket() { [ -n "$SSH_AUTH_SOCK" ] && [[ "$SSH_AUTH_SOCK" == /private/tmp/com.apple.launchd.*/* ]]; }
agent_works() { ssh-add -l >/dev/null 2>&1; }
start_user_agent() {
  eval "$(ssh-agent -s)" >/dev/null
  ssh-add ~/.ssh/personal >/dev/null 2>&1
}
if ! agent_works && (is_macos_launchd_socket || [ -z "$SSH_AUTH_SOCK" ]); then start_user_agent; fi

# COMPLETIONS & INIT
# Load compinit ONCE before completions
autoload -Uz compinit && compinit

load_completions() {
  (( $+commands[kubectl] )) && source <(kubectl completion zsh)
  (( $+commands[argocd] ))  && source <(argocd completion zsh)
  (( $+commands[helm] ))    && source <(helm completion zsh)
  (( $+commands[just] ))    && source <(just --completions zsh)
  (( $+commands[yq] ))      && source <(yq shell-completion zsh)
  (( $+commands[fzf] ))     && source <(fzf --zsh)
}
load_completions

# EXTERNAL INITS
(( $+commands[oh-my-posh] )) && eval "$(oh-my-posh init zsh --config $XDG_CONFIG_HOME/oh-my-posh/catpuccin_mocha.yaml)"
(( $+commands[zoxide] ))      && eval "$(zoxide init --cmd cd zsh)"
(( $+commands[wt] ))          && eval "$(wt config shell init zsh)"
[[ -s "$NVM_DIR/nvm.sh" ]]    && source "$NVM_DIR/nvm.sh"

# INTEGRATIONS & SYNTAX
# WARN: MUST BE LAST!!
[[ -n $GHOSTTY_RESOURCES_DIR ]] && source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
zstyle ':fzf-tab:*' fzf-flags --bind "tab:toggle+down"
[[ -f ~/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh ]] && source ~/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh
