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

-- Filetype configuration for custom file types
vim.filetype.add({
  filename = {
    ["Dockerfile*"] = "dockerfile",
    ["dockerfile*"] = "dockerfile",
    ["*.dockerfile"] = "dockerfile",
    ["Caddyfile"] = "caddy",
    ["jsutfile"] = "justfile",
  },
  extension = {
    caddy = "caddy",
  },
})

-- Clipboard: OSC52 over SSH, native otherwise
local is_ssh = vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT

if is_ssh then
  local function paste()
    return {
      vim.fn.split(vim.fn.getreg(""), "\n"),
      vim.fn.getregtype(""),
    }
  end

  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = function(reg)
        require("vim.ui.clipboard.osc52").copy(reg)
      end,
      ["*"] = function(reg)
        require("vim.ui.clipboard.osc52").copy(reg)
      end,
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
  }
else
  vim.o.clipboard = "unnamedplus"
end
