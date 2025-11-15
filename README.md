# dotfiles

Bootstrap scripts and dot files for macOS

## Screenshots

![Screenshots](https://i.imgur.com/Ua4AN06.png)
![Screenshots](https://i.imgur.com/DRsRZrG.png)

### Homebrew

1. `xargs brew install < brew/brew_packages`
2. `xargs brew install --cask < brew/brew_casks`

### Install dotfiles

1. Clone this repo to `~`
2. `cd dotfiles`
3. `stow -vvvn .` -> Dry Run
4. `stow -vvv .`
5. `stow -vvvD` -> Unstow

### Oh-my-zsh

1. Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#basic-installation)
2. `git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab`
3. Copy custom prompt to `~/.oh-my-zsh/themes/robbyrussell.zsh-theme`

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
2. Source the `.tmux.conf` using `tmux source-file ./.tmux.conf`
3. Install plugins using `prefix` + `I`

### Delta

A better pager for git

1. (Optional) Install [delta](https://github.com/dandavison/delta) manually

### Neovim + LazyVim

1. (Optional) Install [nvim](https://github.com/neovim/neovim) >= 0.10 manually
2. `nvim`
3. Run lazyvim health check `LazyHealth`
4. Enable _LazyExtras_ within nvim

### [Aerospace](https://github.com/nikitabobko/AeroSpace) - Tiling Window Manager

1. `brew install --cask nikitabobko/tap/aerospace`
2. Check config path: `aerospace config --config-path`
3. macOS system settings -> Mission Control -> Group windows by application

### Lazygit

1. See config: <https://github.com/jesseduffield/lazygit>

### [k9s](https://github.com/derailed/k9s)

Check latest [configuration](https://k9scli.io/topics/config/) if needed!

### Git gpg key

> [!CAUTION]
> Make sure name and email match the one in `.gitconfig`

1. Create one if needed: `gpg --full-generate-key`
2. Install pinentry-mac - GUI for passphrase input
3. `brew install pinentry-mac`
4. Add the following line in `~/.gnupg/gpg-agent.conf` (check `brew --prefix`)
   1. `pinentry-program /opt/homebrew/bin/pinentry-mac`

If anything try:

- Checking the local config file location
- `gpgconf --kill gpg-agent`
- `gpgconf --show-configs`
- `killall gpg-agent`
