local M = {}

local format_range = require("r.format_range")

M.lsp_settings_map = {
  default = function (settings)
    return table.merge({
      capabilities = table.merge(require("cmp_nvim_lsp").default_capabilities(), {
        positionEncodings = { "UTF-16" },
      }),
      on_attach = function (client, buffer)
        local map_opts = {
          noremap = true,
          expr = true,
          silent = true,
          buffer = buffer,
        }
        vim.keymap.set("", "=", format_range, map_opts)
        vim.keymap.set("n", "<localleader>i", vim.lsp.buf.implementation, map_opts)
        vim.keymap.set("n", "<localleader>d", vim.lsp.buf.definition, map_opts)
        vim.keymap.set("n", "<localleader>D", vim.lsp.buf.declaration, map_opts)
        vim.keymap.set("n", "<localleader>r", vim.lsp.buf.references, map_opts)
        vim.keymap.set("n", "<localleader>m", vim.lsp.buf.hover, map_opts)
      end,
    }, settings)
  end,
  ccls = function (settings)
    return table.merge({
      init_options = {
        compilationDatabaseDirectory = "build",
        completion = {
          filterAndSort = false,
        },
        index = {
          multiVersion = 1,
        },
      },
    }, M.lsp_settings_map["default"](settings))
  end,
}

M.config = function (server_name, settings)
  local settings_fn = M.lsp_settings_map[server_name] or M.lsp_settings_map["default"]
  vim.lsp.config(server_name, settings_fn(settings))
end

return M
