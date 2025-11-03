-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.swapfile = false

-- https://www.reddit.com/r/neovim/comments/1ajpdrx/lazyvim_weird_live_grep_root_dir_functionality_in/
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua#L13
-- LazyVim root dir detection
-- Set this to fix "Find" "Grep" to respect "root_dir"
vim.g.root_spec = { "cwd" }
