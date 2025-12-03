-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.swapfile = false

-- https://www.reddit.com/r/neovim/comments/1ajpdrx/lazyvim_weird_live_grep_root_dir_functionality_in/
--
-- cwd      -> Where you open nvim, can be changed by <leader>C or `:cd `
-- root_dir -> Where .git rsides
vim.g.root_spec = { ".git" }

-- Highlight the current column
-- vim.opt.cursorcolumn = true
