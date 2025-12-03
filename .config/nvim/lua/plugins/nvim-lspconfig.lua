-- https://www.lazyvim.org/plugins/lsp
return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      -- TODO: Adjust highlight group to make underline less prominent
      underline = true,
      virtual_text = false,
    },
  },
}
