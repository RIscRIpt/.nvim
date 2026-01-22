lsp_config = require("r.lsp_config")
lsp_config.config("copilot")
lsp_config.config("ccls")
lsp_config.config("pyright")
lsp_config.config("cmake")

vim.diagnostic.config({
  underline = true,
  virtual_text = true,
  virtual_lines = false,
  signs = true,
  float = false,
})
