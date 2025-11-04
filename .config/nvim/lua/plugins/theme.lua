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
    opts = {
      transparent_background = true,
      float = {
        transparent = true,
      },
    },
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
          styles = { -- Style to be applied to different syntax groups
            comments = "italic", -- Value is any valid attr-list value `:help attr-list`
            functions = "NONE",
            keywords = "NONE",
            variables = "NONE",
            conditionals = "italic",
            constants = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
          },
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "rose-pine",
      colorscheme = "catppuccin-mocha",
      -- colorscheme = "github_dark_tritanopia",
    },
  },
}
