# dotfiles

Bootstrap scripts and dotfiles for macOS

## Screenshots

![Screenshots](https://i.imgur.com/Ua4AN06.png)
![Screenshots](https://i.imgur.com/DRsRZrG.png)

## Quick Start

```bash
# 1. Install Homebrew packages
xargs brew install < brew/brew_packages
xargs brew install --cask < brew/brew_casks

# 2. Clone and setup dotfiles
git clone https://github.com/kevinchanO777/dotfiles ~/dotfiles
cd ~/dotfiles
stow -vvv .

# 3. Install oh-my-zsh and plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
```

## Prerequisites

- macOS (tested on latest versions)
- Homebrew package manager
- Git

## Installation

### Homebrew

```bash
xargs brew install < brew/brew_packages
xargs brew install --cask < brew/brew_casks
```

### Dotfiles

Using GNU Stow for symlink management:

```bash
# Clone to home directory
git clone https://github.com/kevinchanO777/dotfiles ~/dotfiles
cd ~/dotfiles

# Dry run to check what will be linked
stow -vvvn .

# Link all dotfiles
stow -vvv .

# Unlink all dotfiles
stow -vvvD
```

### Oh-my-zsh

1. Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#basic-installation)
2. Install fzf-tab plugin:

   ```bash
   git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
   ```

3. Copy custom prompt to `~/.oh-my-zsh/themes/robbyrussell.zsh-theme`
4. See `docs/robbyrussell.zsh-theme` for the theme configuration

### Tmux

1. Install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (TPM)
2. Source the config: `tmux source-file ~/.tmux.conf`
3. Install plugins: `prefix` + `I`

### Neovim + LazyVim

1. Install [nvim](https://github.com/neovim/neovim) >= 0.10
2. Run `nvim` to initialize LazyVim
3. Run health check: `:LazyHealth`
4. Enable extras: `:LazyExtras`

### Aerospace (Tiling Window Manager)

1. `brew install --cask nikitabobko/tap/aerospace`
2. Check config path: `aerospace config --config-path`
3. macOS System Settings → Mission Control → Group windows by application

### Other Tools

- **Delta**: Better git pager (install via Homebrew)
- **Lazygit**: Git UI tool - see [config](https://github.com/jesseduffield/lazygit)
- **k9s**: Kubernetes CLI - see [configuration](https://k9scli.io/topics/config/)

### Git GPG Key Setup

> [!CAUTION]
> Ensure name and email match `.gitconfig`

```bash
# 1. Create GPG key if needed
gpg --full-generate-key

# 2. Install pinentry-mac
brew install pinentry-mac

# 3. Configure GPG agent
echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf

# 4. Restart GPG agent
gpgconf --kill gpg-agent
```

## Troubleshooting

### Stow Issues

- **Target already exists**: Remove existing files or use `--adopt` flag
- **Permission denied**: Check file permissions in target directories

### GPG Issues

```bash
# Check GPG agent status
gpgconf --show-configs

# Restart GPG agent
killall gpg-agent
gpgconf --launch gpg-agent
```

### Tmux Plugin Issues

- Ensure TPM is installed in `~/.tmux/plugins/tpm`
- Check tmux version compatibility (>= 2.0)

### Neovim Issues

- Run `:checkhealth` for diagnostics
- Ensure all dependencies are installed via Mason

### Bat Issues

- If bat throws a warning and falls back to default theme, reload the theme
  using `bat cache --build`

## Directory Structure

```sh
dotfiles/
├── .config/          # Application configs
├── brew/             # Homebrew packages list
├── docs/             # Documentation files
└── .stow-local-ignore # Files to ignore during stow
```
