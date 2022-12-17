local lsp = require("lspconfig")
local cmp = require("cmp_nvim_lsp")

function format_range()
    if _G.format_op ~= nil then
        vim.api.nvim_feedkeys("\x1B", "n", false)
        return _G.format_op()
    end
    local old_op_fn = vim.go.operatorfunc
    _G.format_op = function()
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

function common_on_attach(client, buffer)
    local map_opts = {
        noremap = true,
        expr = true,
        silent = true,
        buffer = buffer,
    }
    vim.keymap.set("", "=", format_range, map_opts)
end

lsp.ccls.setup({
    capabilities = cmp.default_capabilities(),
    init_options = {
        compilationDatabaseDirectory = "build",
        completion = {
            filterAndSort = false,
        },
        index = {
            multiVersion = 1,
        },
    },
    on_attach = common_on_attach,
})

lsp.pyright.setup({
    on_attach = common_on_attach,
})

lsp.cmake.setup({
    on_attach = common_on_attach,
})

