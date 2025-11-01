# dotfiles

Bootstrap scripts and dot files for mac

### Oh-my-zsh

1. Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#basic-installation)

### Tmux

1. Install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (TPM)
2. Source the .tmux.conf using `tmux source-file ./.tmux.conf`
3. Install plugins using `prefix` + `I`

### Delta

A better pager for git

1. Install [delta](https://github.com/dandavison/delta)

### Neovim + LazyVim

1. Install [nvim](https://github.com/neovim/neovim) >= 0.10
2. `cp -r nvim .config/`
3. `nvim`
4. Run lazyvim health check `LazyHealth`
5. Enable _LazyExtras_ within nvim

### [yabai](https://github.com/koekeishiya/yabai)

1. `yabai --start-service`

### Lazygit

1. See config: <https://github.com/jesseduffield/lazygit>
2. Change diff pager to _delta_
