-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Telescope Keymaps
-- local builtin = require("telescope.builtin")
-- vim.keymap.set("n", "<C-P>", builtin.find_files, { desc = "Telescope find files" })
-- vim.keymap.set("n", "<leader>ag", builtin.live_grep, { desc = "Telescope find files" })

-- Exit insert mode by 'jj'
vim.keymap.set("i", "jj", "<Esc>")

-- Save file using <cmd-s> for macOS
vim.keymap.set({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Change CWD
vim.g.startup_cwd = vim.fn.getcwd()

vim.keymap.set("n", "<leader>Cc", function()
  local cwd = vim.fn.expand("%:p:h")
  vim.cmd("cd " .. cwd)
  print("Changed CWD to: " .. cwd)
end, { desc = "Change CWD to Current Buffer" })

vim.keymap.set("n", "<leader>Cs", function()
  if vim.g.startup_cwd then
    vim.cmd("cd " .. vim.g.startup_cwd)
    print("Changed CWD: " .. vim.g.startup_cwd)
  else
    print("Startup directory not set.")
  end
end, { desc = "Change CWD to Startup Directory" })
