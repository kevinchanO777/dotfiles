return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      signature = {
        enabled = false, -- blink-cmp.nvim handle signature
      },
    },
    cmdline = {
      view = "cmdline",
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
  },
}
