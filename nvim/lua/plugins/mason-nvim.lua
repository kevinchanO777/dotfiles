return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "docker-language-server",
        "dockerfile-language-server",
        "shellcheck",
      },
    },
  },
}
