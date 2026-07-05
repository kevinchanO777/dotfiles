# History Settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY                            # Don't overwrite history
setopt INC_APPEND_HISTORY                        # Write immediately
setopt EXTENDED_HISTORY                          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY                             # Share history between all sessions.

setopt HIST_EXPIRE_DUPS_FIRST                    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS                         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS                      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS                          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE                         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS                         # Do not write a duplicate event to the history file.

# Keybinds
bindkey -e  # Emacs mode

# ENV
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export COLIMA_HOME="$XDG_CONFIG_HOME/colima"
export DOCKER_HOST="unix://$HOME/.config/colima/default/docker.sock"
export EDITOR="nvim"
export KUBE_EDITOR="nvim"
export MANPAGER='nvim +Man!'
export GPG_TTY=$(tty)
export HOMEBREW_AUTO_UPDATE_SECS=1036800

# TOOL SETTINGS
export BAT_THEME="Catppuccin Mocha"
export K9S_SKIN="catppuccin-mocha"
export K9S_FEATURE_GATE_NODE_SHELL=true
export FZF_COMPLETION_OPTS='--multi'
export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# HOMEBREW
eval "$(brew shellenv)"
fpath=($HOME/.zsh/completions $HOMEBREW_PREFIX/share/zsh/site-functions $fpath)
[[ -d "$HOME/.docker/completions" ]] && fpath=("$HOME/.docker/completions" $fpath)

# COMPLETION CACHE
_completion_cache_dir="$HOME/.zsh/cache/completions"
_needs_rebuild=0
_zsh_cache_completion() {
  local cmd=$1; shift
  local comp_file="${_completion_cache_dir}/_${cmd}"
  local bin_path=$(command -v "$cmd" 2>/dev/null)
  [[ -n "$bin_path" ]] || return
  if [[ ! -s "$comp_file" ]] || [[ "$bin_path" -nt "$comp_file" ]]; then
    mkdir -p "$_completion_cache_dir" 2>/dev/null
    "$@" > "$comp_file" 2>/dev/null
    _needs_rebuild=1
  fi
}

_zsh_cache_completion kubectl kubectl completion zsh
_zsh_cache_completion argocd argocd completion zsh
_zsh_cache_completion helm helm completion zsh
_zsh_cache_completion just env JUST_COMPLETE=zsh just
_zsh_cache_completion yq yq shell-completion zsh
_zsh_cache_completion sesh sesh completion zsh
_zsh_cache_completion trivy trivy completion zsh

fpath=("$_completion_cache_dir" $fpath)

# ALIASES
alias c='clear'
alias rb='source ~/.zshrc'
alias path='echo -e ${PATH//:/\\n}'
alias nv='nvim'
alias fc='fc -e nvim'
alias l='eza --color=always --icons=auto --group-directories-first -l --git -h --time-style=long-iso'
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

# COMPINIT
autoload -Uz compinit
if [[ ! -f ~/.zcompdump ]] || [[ ~/.zshrc -nt ~/.zcompdump ]] || (( _needs_rebuild )); then
  compinit
else
  compinit -C
fi

# fzf key bindings + completions
(( $+commands[fzf] )) && source <(fzf --zsh)

unset _needs_rebuild _completion_cache_dir
unfunction _zsh_cache_completion

(( $+commands[oh-my-posh] )) && eval "$(oh-my-posh init zsh --config $XDG_CONFIG_HOME/oh-my-posh/catppuccin_mocha.yaml)"
(( $+commands[zoxide] ))      && eval "$(zoxide init --cmd cd zsh)"
(( $+commands[wt] ))          && eval "$(wt config shell init zsh)"

[[ -n $GHOSTTY_RESOURCES_DIR ]] && source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration

source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$(brew --prefix)/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh"

zstyle ':fzf-tab:*' fzf-flags --bind "tab:toggle+down"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':completion:*:*:kill:*:processes' command 'ps -A -o pid,user,comm'
