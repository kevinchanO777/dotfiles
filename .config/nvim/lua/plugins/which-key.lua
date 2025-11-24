-- See keymaps.lua
return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      mode = { "n", "x" },
      { "<leader>C", group = "Change CWD" },
    },
  },
}
