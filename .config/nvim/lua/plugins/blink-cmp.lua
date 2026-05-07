-- blink-cmp is a completion plugin with support for LSPs, cmdline, signature help and snippets.
--
--
-- Documentation: https://cmp.saghen.dev/
return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "default",
      ["<C-space>"] = false,
      ["<C-l>"] = { "show", "show_documentation", "hide_documentation" },
    },

    completion = {

      menu = {
        auto_show_delay_ms = 500,
        border = "rounded",
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        window = {
          border = "rounded",
          max_width = 60,
          max_height = 20,
        },
      },
    },

    signature = {
      enabled = true,
      window = {
        border = "rounded",
        max_height = 10,
        show_documentation = true,
      },
    },
  },
}
