vim.g.coq_settings = {
    auto_start = "shut-up",
    display = {
        ghost_text = {
            enabled = false,
        },
        pum = {
            fast_close = false,
            x_max_len = 128,
            y_max_len = 64,
            y_ratio = 0.9,
            ellipsis = "...",
            kind_context = { "", "" },
            source_context = { "", "" },
        },
        preview = {
            x_max_len = 128,
            border = {
                { "",  "NormalFloat" },
                { "",  "NormalFloat" },
                { "",  "NormalFloat" },
                { " ", "NormalFloat" },
                { "",  "NormalFloat" },
                { "",  "NormalFloat" },
                { "",  "NormalFloat" },
                { " ", "NormalFloat" },
            },
        },
        icons = {
            mode = "short",
        },
    },
}

