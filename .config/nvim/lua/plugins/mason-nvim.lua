-- LSP
-- Use `MasonInstall` command
return {
  {
    "mason-org/mason.nvim",
    opts = {
      -- Mason install binaries in ~/.local/share/nvim/mason/bin
      -- And prepend it to PATH when Mason is loaded in Neovim
      ensure_installed = {
        "stylua",
        "shfmt",
        "docker-language-server",
        "dockerfile-language-server",
        "shellcheck",
        "bash-language-server",
        "yamlfmt",
        "kube-linter",
        "yaml-language-server",
        "gopls",
        "helm-ls",
        "prettier",
      },
      ui = {
        border = "rounded",
      },
    },
  },
}
