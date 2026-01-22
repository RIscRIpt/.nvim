local function format_range()
  if _G.format_op ~= nil then
    vim.api.nvim_feedkeys("\x1B", "n", false)
    return _G.format_op()
  end
  local old_op_fn = vim.go.operatorfunc
  _G.format_op = function ()
    local start = vim.api.nvim_buf_get_mark(0, "[")
    local finish = vim.api.nvim_buf_get_mark(0, "]")
    if start[1] >= finish[1] and start[2] >= finish[2] then
      start = { start[1], 0 }
      finish = { finish[1], -1 }
    end
    vim.lsp.buf.format({
      range = { start = start, ["end"] = finish },
      timeout_ms = 10000
    })
    vim.go.operatorfunc = old_op_fn
    _G.format_op = nil
  end
  vim.go.operatorfunc = "v:lua.format_op"
  vim.api.nvim_feedkeys("g@", "n", false)
end

vim.lsp.set_log_level("off")

vim.lsp.config("*", {
  capabilities = vim.tbl_extend("force", require("cmp_nvim_lsp").default_capabilities(), {
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
})

vim.lsp.config("ccls", {
  init_options = {
    compilationDatabaseDirectory = "build",
    completion = {
      filterAndSort = false,
    },
    index = {
      multiVersion = 1,
    },
  },
})

vim.diagnostic.config({
  underline = true,
  virtual_text = true,
  virtual_lines = false,
  signs = true,
  float = false,
})

if vim.fn.has("mac") == 1 then
  vim.system({ "xcrun", "--show-sdk-path" }, { text = true }, function (result)
    vim.schedule(function ()
      if result.code ~= 0 then
        vim.notify("Failed to get Xcode SDK path: " .. result.stderr, vim.log.levels.WARN)
        return
      end
      vim.lsp.config("ccls", {
        init_options = {
          clang = {
            extraArgs = { "-isysroot", vim.trim(result.stdout) },
          },
        },
      })
    end)
  end)
end
