-- https://www.reddit.com/r/neovim/comments/1ittmg3/hidden_files_in_lazyvim/
return {
  {
    "folke/snacks.nvim",
    opts = {
      -- https://github.com/folke/snacks.nvim/blob/main/docs/image.md
      image = {},
      lazygit = {
        -- automatically configure lazygit to use the current colorscheme
        -- and integrate edit with the current neovim instance
        configure = false,
      },
      picker = {
        hidden = true, -- for hidden files
        ignored = true, -- for .gitignore files
        sources = {
          files = {
            hidden = true,
          },
        },
      },
    },
  },
}
