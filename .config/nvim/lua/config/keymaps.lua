-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Telescope Keymaps
-- local builtin = require("telescope.builtin")
-- vim.keymap.set("n", "<C-P>", builtin.find_files, { desc = "Telescope find files" })
-- vim.keymap.set("n", "<leader>ag", builtin.live_grep, { desc = "Telescope find files" })

--  Stay at center when scrolling
vim.keymap.set("n", "j", "jzz", { noremap = true })
vim.keymap.set("n", "k", "kzz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Paste over selected text without overwriting the clipboard register
vim.keymap.set("x", "<leader>p", [["_dP]])

--  Keep serach result at center of page
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Exit insert mode by 'jj'
vim.keymap.set("i", "jj", "<Esc>")

-- Save file using <cmd-s> for macOS
vim.keymap.set({ "i", "x", "n", "s" }, "<D-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

--
--
-- Custom scripts
--
--

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

-- Yank File Path
vim.keymap.set("n", "<leader>Y", function()
  local path = vim.fn.expand("%:p") -- same as above, shorter
  vim.cmd.let('@+ = "' .. path .. '"')
  vim.notify(path)
end, { desc = "Yank absolute file path" })

-- TODO: Adjust notify-nvim/noice-nvim color
--
-- Toggle LSP diagnostics virtual text
vim.keymap.set("n", "<leader>uv", function()
  local current_config = vim.diagnostic.config()

  local is_virtual_text_enabled = current_config and current_config.virtual_text or false
  local new_virtual_text = not is_virtual_text_enabled

  vim.diagnostic.config({
    virtual_text = new_virtual_text,
  })
  if new_virtual_text then
    vim.notify("Enable Diagnostics Virtual Text", vim.log.levels.INFO)
  else
    vim.notify("Disable Diagnostics Virtual Text", vim.log.levels.WARN)
  end
end, { desc = "Toggle Virtual Text Diagnostics" })

-- Generate pseudo-random bytes
vim.keymap.set("n", "<leader>og", function()
  local cmd = "openssl rand -base64 32 | tr -d '\\n'"
  local handle = io.popen(cmd)

  if not handle then
    vim.notify("Failed to execute openssl command", vim.log.levels.ERROR)
    return
  end

  local result = handle:read("*a")
  handle:close()

  if result and result ~= "" then
    vim.api.nvim_put({ result }, "c", true, true)
  else
    vim.notify("Command returned no output", vim.log.levels.WARN)
  end
end, { desc = "Generate Random Base64" })
