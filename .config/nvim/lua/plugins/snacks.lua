-- https://www.reddit.com/r/neovim/comments/1ittmg3/hidden_files_in_lazyvim/
return {
  {
    "folke/snacks.nvim",
    opts = {
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
