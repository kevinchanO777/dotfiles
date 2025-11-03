-- <leader>uC to change colorscheme
return {
  {
    "rose-pine/neovim",
    name = "rosepine",
    opts = {
      styles = {
        transparency = true,
      },
    },
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = { style = "moon" },
  },

  {
    "catppuccin/nvim",
    lazy = false,
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
  },

  {
    "shaunsingh/nord.nvim",
    lazy = false,
  },

  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
  },

  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
        },
      })

      vim.cmd("colorscheme github_dark")
    end,
  },

  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "github_dark_high_contrast",
  --   },
  -- },
}
