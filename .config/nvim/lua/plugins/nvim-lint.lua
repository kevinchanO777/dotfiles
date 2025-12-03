-- ~/.config/nvim/lua/plugins/nvim-lint.lua
return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      -- Existing linters might be here
      yaml = { "yamllint" },
      dockerfile = { "hadolint" },
    },
  },
}
