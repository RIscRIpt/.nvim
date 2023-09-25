local lsp = require("lspconfig")
local cmp = require("cmp_nvim_lsp")

function format_range()
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

lsp_settings_map = {
    default = function (params)
        return {
            capabilities = cmp.default_capabilities(),
            on_attach = function (client, buffer)
                local map_opts = {
                    noremap = true,
                    expr = true,
                    silent = true,
                    buffer = buffer,
                }
                vim.keymap.set("", "=", format_range, map_opts)
                vim.keymap.set("n", "<A-i>", vim.lsp.buf.implementation, map_opts)
                vim.keymap.set("n", "<A-d>", vim.lsp.buf.definition, map_opts)
                vim.keymap.set("n", "<A-D>", vim.lsp.buf.declaration, map_opts)
                vim.keymap.set("n", "<A-r>", vim.lsp.buf.references, map_opts)
                vim.keymap.set("n", "<A-m>", vim.lsp.buf.hover, map_opts)
            end,
        }
    end,
    ccls = function (params)
        return {
            init_options = {
                compilationDatabaseDirectory = params.build_dir or "build",
                completion = {
                    filterAndSort = false,
                },
                index = {
                    multiVersion = 1,
                },
            },
            table.unpack(lsp_settings_map["default"](params))
        }
    end,
}

function lsp_setup(server_name, params)
    local settings_fn = lsp_settings_map[server_name] or lsp_settings_map["default"]
    lsp[server_name].setup(settings_fn(params))
end
