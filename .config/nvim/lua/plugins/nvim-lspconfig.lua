return {
  {
    "cenk1cenk2/schema-companion.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      log_level = vim.log.levels.INFO,
    },
    config = function(_, opts)
      require("schema-companion").setup(opts)
      -- <leader>as: pick any available schema; <leader>am: pick from auto-matched only
      vim.keymap.set("n", "<leader>as", require("schema-companion").select_schema, { desc = "Select Schema" })
      vim.keymap.set("n", "<leader>am", require("schema-companion").select_matching_schema, {
        desc = "Select Matching Schema",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
        virtual_text = false,
      },
      servers = {
        yamlls = {},
        jsonls = {},
      },
      setup = {
        yamlls = function(server, server_opts)
          server_opts.settings = server_opts.settings or {}
          server_opts.settings.yaml = server_opts.settings.yaml or {}
          -- schema-companion manages schemas; disable built-in schemaStore to avoid conflicts
          server_opts.settings.yaml.schemaStore = { enable = false, url = "" }

          -- Matcher: docker-compose files → official compose-spec.json
          local compose_matcher = { name = "DockerComposeMatcher" }
          function compose_matcher.match(_, _, bufnr)
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            local filename = vim.fn.fnamemodify(bufname, ":t")
            for _, p in ipairs({
              "docker-compose*.yaml",
              "docker-compose*.yml",
              "compose*.yaml",
              "compose*.yml",
            }) do
              if vim.fn.match(filename, vim.fn.glob2regpat(p)) >= 0 then
                return {
                  {
                    name = "Docker Compose Specification",
                    uri = "https://raw.githubusercontent.com/compose-spec/compose-go/master/schema/compose-spec.json",
                    source = compose_matcher.name,
                  },
                }
              end
            end
            return {}
          end

          -- Sources are evaluated in order; first match wins for selection,
          -- but all matched schemas are available for manual override via <leader>as.
          local adapter = require("schema-companion").adapters.yamlls.setup({
            sources = {
              require("schema-companion").sources.matchers.kubernetes.setup({ version = "master" }),
              compose_matcher,
            },
          })

          -- on_update_schemas override: default adapter starts from an empty override table,
          -- which drops any previously-registered schemas for OTHER buffers. This is fine
          -- when each buffer has a unique schema URL (e.g. different k8s resources), but
          -- breaks when multiple buffers share the same schema URL (e.g. two compose files
          -- both mapping to compose-spec.json). This fix preserves all existing associations
          -- and collects multiple file URIs into an array for shared schema URLs.
          function adapter:on_update_schemas(bufnr, schemas)
            local bufuri = vim.uri_from_bufnr(bufnr)
            local client = self:get_client()

            local existing = {}
            if vim.tbl_get(client, "settings", "yaml", "schemas") then
              existing = vim.deepcopy(client.settings.yaml.schemas)
            end

            -- Remove the current buffer from any schema it was previously associated with
            for uri, val in pairs(existing) do
              if type(val) == "string" and val == bufuri then
                existing[uri] = nil
              elseif type(val) == "table" then
                local filtered = vim.tbl_filter(function(v)
                  return v ~= bufuri
                end, val)
                if #filtered == 0 then
                  existing[uri] = nil
                else
                  existing[uri] = #filtered == 1 and filtered[1] or filtered
                end
              end
            end

            -- Add new schemas, merging with existing entries for the same schema URL
            for _, s in ipairs(schemas) do
              local cur = existing[s.uri]
              if not cur then
                existing[s.uri] = bufuri
              elseif type(cur) == "string" then
                existing[s.uri] = cur ~= bufuri and { cur, bufuri } or cur
              elseif type(cur) == "table" then
                if not vim.tbl_contains(cur, bufuri) then
                  table.insert(cur, bufuri)
                end
              end
            end

            client.settings = vim.tbl_deep_extend("force", client.settings, { yaml = { schemas = existing } })
            client:notify("workspace/didChangeConfiguration", { settings = client.settings })
          end

          local final_opts = require("schema-companion").setup_client(adapter, server_opts)
          require("lspconfig")[server].setup(final_opts)
          return true
        end,

        jsonls = function(server, server_opts)
          local adapter = require("schema-companion").adapters.jsonls.setup({
            sources = {
              require("schema-companion").sources.lsp.setup(),
            },
          })
          local final_opts = require("schema-companion").setup_client(adapter, server_opts)
          require("lspconfig")[server].setup(final_opts)
          return true
        end,
      },
    },
  },
}
