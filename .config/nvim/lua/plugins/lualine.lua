return {
  "nvim-lualine/lualine.nvim",
  optional = true,
  opts = function(_, opts)
    table.insert(opts.sections.lualine_c, {
      function()
        return require("schema-companion").get_current_schemas()
      end,
      cond = function()
        return package.loaded["schema-companion"] and require("schema-companion").get_current_schemas() ~= nil
      end,
    })
  end,
}
