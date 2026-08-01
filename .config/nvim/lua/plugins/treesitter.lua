-- See: https://www.lazyvim.org/plugins/treesitter#nvim-treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    opts = {
      ensure_installed = {
        "caddy",
        "just",
      },
    },
  },
}
