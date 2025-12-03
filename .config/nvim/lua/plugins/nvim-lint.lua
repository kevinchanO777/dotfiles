-- ~/.config/nvim/lua/plugins/nvim-lint.lua
return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      yaml = { "yamllint", "kube_linter" },
      dockerfile = { "hadolint" },
    },
  },
  config = function(_, opts)
    local lint = require("lint")

    -- Custom kube-linter configuration for Kubernetes YAML linting
    -- Uses JSON output format for structured parsing
    lint.linters.kube_linter = {
      name = "kube_linter",
      cmd = "kube-linter",
      stdin = true,
      args = { "lint", "--format", "json", "-" },
      ignore_exitcode = true, -- kube-linter returns non-zero on errors
      parser = function(output)
        local diagnostics = {}
        local ok, data = pcall(vim.json.decode, output)

        if ok and data.Reports and type(data.Reports) == "table" then
          for _, report in ipairs(data.Reports) do
            local obj = report.Object.K8sObject
            local severity = vim.diagnostic.severity.WARN

            -- Map critical security checks to ERROR severity
            if report.Check:match("privileged") or report.Check:match("docker%-sock") then
              severity = vim.diagnostic.severity.ERROR
            end

            local diagnostic = {
              lnum = 0, -- kube-linter doesn't provide line numbers
              col = 0,
              message = string.format(
                "[%s] %s (%s %s)\nRemediation: %s",
                report.Check,
                report.Diagnostic.Message,
                obj.Kind or "Object",
                obj.Name or "unknown",
                report.Remediation
              ),
              severity = severity,
              source = "kube-linter",
              code = report.Check,
            }
            table.insert(diagnostics, diagnostic)
          end
        end

        return diagnostics
      end,
    }

    -- Apply the configuration
    lint.linters_by_ft = opts.linters_by_ft

    -- Set up autocmd to trigger linting on file read and save
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
