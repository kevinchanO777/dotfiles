return {
  "lewis6991/gitsigns.nvim",

  opts = function(_, opts)
    opts.current_line_blame = true
    opts.word_diff = false

    --
    --
    -- Override lazyvim default: https://www.lazyvim.org/plugins/editor#gitsignsnvim-1
    --
    -- nav_hunk target both staged and unstaged
    --
    --
    local default_on_attach = opts.on_attach

    opts.on_attach = function(buffer)
      if default_on_attach then
        default_on_attach(buffer)
      end

      local gs = package.loaded.gitsigns

      vim.keymap.set("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next", { target = "all" })
        end
      end, { buffer = buffer, desc = "Next Hunk (All)", silent = true })

      vim.keymap.set("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev", { target = "all" })
        end
      end, { buffer = buffer, desc = "Prev Hunk (All)", silent = true })
    end
  end,
}
