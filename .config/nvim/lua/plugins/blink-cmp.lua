-- Lazyvim default auto completion plugin
return {
  "saghen/blink.cmp",
  opts = {

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 10,
      },
      ghost_text = {
        -- enabled = vim.g.ai_cmp,
        enabled = false,
      },
    },
  },
}
