local lsp = require("lspconfig")
local coq = require("coq")

lsp.ccls.setup(coq.lsp_ensure_capabilities({
    init_options = {
        completion = {
            filterAndSort = false,
        },
    },
}))

