# dotfiles

Bootstrap scripts and dotfiles for macOS

## Screenshots

![Screenshots](https://i.imgur.com/Ua4AN06.png)
![Screenshots](https://i.imgur.com/DRsRZrG.png)

## Prerequisites

- macOS
- Homebrew
- Git

## Quick Start

```bash
# 1. Install Homebrew packages from `Brewfile`
brew bundle

# 2. Clone and setup dotfiles
git clone https://github.com/kevinchanO777/dotfiles ~/dotfiles
cd ~/dotfiles
stow -vvv .
```

## Details

### Homebrew

To generate Brewfile:

```bash
brew bundle dump --force --describe
```

### Dotfiles

Using GNU Stow for dotfiles symlink management:

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

### Tmux

1. Install [tmux](https://github.com/tmux/tmux) and [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (TPM)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

1. Source the config: `tmux source-file ~/.tmux.conf`
2. Install plugins: `prefix` + `I`

### Neovim + LazyVim

1. Install [nvim](https://github.com/neovim/neovim) >= 0.12 (0.11 should work)
2. Run `nvim` to initialize LazyVim
3. Run health check: `:LazyHealth`
4. Enable extras: `:LazyExtras`

### Aerospace (Tiling Window Manager)

1. Check config path: `aerospace config --config-path`
2. macOS System Settings → Mission Control → Group windows by application

### Git GPG Key Setup

> [!CAUTION]
> Ensure name and email match `.gitconfig`

```bash
# 1. Create GPG key if needed
gpg --full-generate-key

# 2. Install pinentry
brew install pinentry

# 3. Install configs
stow -v .

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

# Reload conf:
gpgconf --reload

# Manually disable gpg in lazygit and git
`.gitconfig`
[commit]
  gpgSign = false

`lazygit/config.yml`
git:
  overrideGpg: false

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
