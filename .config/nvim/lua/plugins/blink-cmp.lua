-- Lazyvim default auto completion plugin
return {
  "saghen/blink.cmp",
  opts = {

    completion = {
      menu = {
        border = "rounded",
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 10,
        window = {
          border = "rounded",
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
      },
      ghost_text = {
        -- enabled = vim.g.ai_cmp,
        enabled = false,
      },
    },
    -- Custom keymaps for documentation navigation
    keymap = {
      -- Default: https://cmp.saghen.dev/configuration/keymap.html
      preset = "default",
      ["<C-j>"] = { "scroll_documentation_down", "fallback" },
      ["<C-k>"] = { "scroll_documentation_up", "fallback" },
      -- ["<C-f>"] = { "show_documentation", "fallback" },
      -- ["<C-h>"] = { "hide_documentation", "fallback" },
    },
  },
  -- -- Add highlight groups to make background opaque
  highlights = {
    BlinkCmpMenu = { bg = "#1e1e2e" },
    BlinkCmpDoc = { bg = "#1e1e2e" },
    BlinkCmpMenuBorder = { fg = "#585b70" },
    BlinkCmpDocBorder = { fg = "#585b70" },
    BlinkCmpMenuSelection = { bg = "#313244" },
    BlinkCmpDocCursorLine = { bg = "#313244" },
  },
}
