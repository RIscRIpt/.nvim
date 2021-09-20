local lsp = require("lspconfig")
local coq = require("coq")

lsp.ccls.setup(coq.lsp_ensure_capabilities({
    init_options = {
        compilationDatabaseDirectory = "build",
        completion = {
            filterAndSort = false,
        },
        index = {
            multiVersion = 1,
        },
    },
}))

