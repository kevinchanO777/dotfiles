return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    -- Don't override your existing keymaps
    max_time = 1000,
    max_count = 3,
    disable_mouse = true,
    hint = true,
    notification = true,
    timeout = 3000,
    allow_different_key = true,
    enabled = true,
    
    -- Allow your current keymaps to work
    disabled_keys = {
      ["<Up>"] = false, -- Allow arrow keys if you need them
      ["<Down>"] = false,
      ["<Left>"] = false,
      ["<Right>"] = false,
      ["<leader>"] = false, -- Allow all leader key combinations
      ["<C-"] = false, -- Allow all Ctrl combinations
    },
    
    -- Disable in specific filetypes where it might be annoying
    disabled_filetypes = {
      "lazy",
      "mason",
      "TelescopePrompt",
      "dapui_*",
      "neo-tree",
      "toggleterm",
    },
    
    -- Restrict only basic movement spamming
    restricted_keys = {
      ["h"] = { "n", "x" },
      ["j"] = { "n", "x" },
      ["k"] = { "n", "x" },
      ["l"] = { "n", "x" },
    },
    
    -- Custom hints for your workflow
    hints = {
      ["hjkl"] = {
        message = function(keys)
          return "Try: w/b/e for words, f/t for jumps, or 5j/10l for counts"
        end,
        length = 4,
      },
      ["d[tTfF].i"] = {
        message = function(keys)
          return "Use c" .. keys:sub(2, 3) .. " instead of " .. keys
        end,
        length = 4,
      },
    },
    
    -- Use nvim-notify for better notifications (if available)
    callback = function(text)
      if vim.notify then
        vim.notify(text, vim.log.levels.INFO, { title = "Hardtime" })
      else
        vim.notify(text)
      end
    end,
  },
}