-- ~/.config/nvim/lua/plugins/nvim-lint.lua
return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      --  Install missing linters by `:MasonInstall <linter>`
      ["yaml"] = { "yamllint" },
      ["yaml.k8s"] = { "yamllint", "kube_linter" },
      ["dockerfile"] = { "hadolint" },
    },
  },
  config = function(_, opts)
    local lint = require("lint")

    -- kube-linter (custom parser)
    lint.linters.kube_linter = {
      name = "kube_linter",
      cmd = "kube-linter",
      stdin = true,
      args = { "lint", "--format", "json", "-" },
      ignore_exitcode = true,
      parser = function(output)
        local diagnostics = {}
        local ok, data = pcall(vim.json.decode, output)
        if not ok or not data or type(data.Reports) ~= "table" then
          return diagnostics
        end

        for _, report in ipairs(data.Reports) do
          local obj = (report.Object and report.Object.K8sObject) or {}
          local severity = report.Diagnostic.Severity == "error" and vim.diagnostic.severity.ERROR
            or vim.diagnostic.severity.WARN

          table.insert(diagnostics, {
            lnum = 0, -- kube-linter often doesn't give line numbers
            col = 0,
            end_lnum = 0,
            end_col = 0,
            message = string.format(
              "[%s] %s (%s/%s)",
              report.Check,
              report.Diagnostic.Message,
              obj.Kind or "Unknown",
              obj.Name or "unknown"
            ),
            severity = severity,
            source = "kube-linter",
            code = report.Check,
          })
        end
        return diagnostics
      end,
    }

    lint.linters_by_ft = opts.linters_by_ft

    -- Auto lint on events
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
