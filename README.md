# dotfiles

Bootstrap scripts and dot files for mac

### Homebrew

1. `xargs brew install < brew_packages`
2. `xargs brew install --cask < brew_casks`

### Install dotfiles

1. Clone this repo to `~`
2. `cd dotfiles`
3. `stow .`

### Oh-my-zsh

1. Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#basic-installation)
2. Copy custom prompt to `~/.oh-my-zsh/themes/robbyrussell.zsh-theme`

`robbyrussell.zsh-theme`

```
PROMPT='[%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%}@%M:%{$fg[red]%}%30<...<%~%<<%{$reset_color%}]%(!.#.$) '
RPROMPT='$(git_prompt_info)'

# PROMPT+=' $(git_prompt_info)'

# PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%}"
# PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
```

### Tmux

1. Install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (TPM)
2. Source the .tmux.conf using `tmux source-file ./.tmux.conf`
3. Install plugins using `prefix` + `I`

### Delta

A better pager for git

1. (Optional) Install [delta](https://github.com/dandavison/delta) manually

### Neovim + LazyVim

1. (Optional) Install [nvim](https://github.com/neovim/neovim) >= 0.10 manually
2. `nvim`
3. Run lazyvim health check `LazyHealth`
4. Enable _LazyExtras_ within nvim

### [yabai](https://github.com/koekeishiya/yabai) - Tiling Window Manager

1. `yabai --start-service`
2. To reload config `yabai --restart-service`

### [JankyBorders](https://github.com/FelixKratz/JankyBorders)

```
brew tap FelixKratz/formulae
brew install borders
```

### Lazygit

1. See config: <https://github.com/jesseduffield/lazygit>
2. For Mac: `cp .config/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml`
