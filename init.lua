vim.cmd("source " .. vim.fn.stdpath("config") .. "/settings.vim")
vim.cmd("packadd packer.nvim")

require("coq_settings")

require("packer").startup(function(use)
    use { "neovim/nvim-lspconfig" }
    use {
        "ms-jpq/coq_nvim",
        branch = "coq",
    }
    use {
        "ms-jpq/coq.artifacts",
        branch = "artifacts",
        requires = { { "ms-jpq/coq_nvim" } },
    }
    use {
        "ms-jpq/coq.thirdparty",
        branch = "3p",
        requires = { { "ms-jpq/coq_nvim" } },
    }
    use {
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
    }
    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").load_extension("file_browser")
        end
    }
    use {
        "lewis6991/gitsigns.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { hl = "GitSignsAdd",    text = nil, numhl = "GitSignsAddNr",    linehl = "GitSignsAddLn" },
                    change       = { hl = "GitSignsChange", text = nil, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                    delete       = { hl = "GitSignsDelete", text = nil, numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                    topdelete    = { hl = "GitSignsDelete", text = nil, numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                    changedelete = { hl = "GitSignsChange", text = nil, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                },
                keymaps = {
                    noremap = true,
                    ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require(\"gitsigns.actions\").next_hunk()<CR>'" },
                    ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require(\"gitsigns.actions\").prev_hunk()<CR>'" },
                    ["n <leader>hs"] = "<cmd>lua require(\"gitsigns\").stage_hunk()<CR>",
                    ["v <leader>hs"] = "<cmd>lua require(\"gitsigns\").stage_hunk({vim.fn.line(\".\"), vim.fn.line(\"v\")})<CR>",
                    ["n <leader>hu"] = "<cmd>lua require(\"gitsigns\").undo_stage_hunk()<CR>",
                    ["n <leader>hr"] = "<cmd>lua require(\"gitsigns\").reset_hunk()<CR>",
                    ["v <leader>hr"] = "<cmd>lua require(\"gitsigns\").reset_hunk({vim.fn.line(\".\"), vim.fn.line(\"v\")})<CR>",
                    ["n <leader>hR"] = "<cmd>lua require(\"gitsigns\").reset_buffer()<CR>",
                    ["n <leader>hp"] = "<cmd>lua require(\"gitsigns\").preview_hunk()<CR>",
                    ["n <leader>hb"] = "<cmd>lua require(\"gitsigns\").blame_line(true)<CR>",
                    ["n <leader>hS"] = "<cmd>lua require(\"gitsigns\").stage_buffer()<CR>",
                    ["n <leader>hU"] = "<cmd>lua require(\"gitsigns\").reset_buffer_index()<CR>",
                },
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true,
                },
                sign_priority = 6,
                numhl      = true,
                linehl     = false,
                signcolumn = false,
                word_diff  = true,
                diff_opts = {
                    internal = false, -- does not work on Windows
                },
                max_file_length = 32768,
                preview_config = {
                    relative = "cursor",
                    anchor = "NE",
                    row = -1024,
                    col = 1024,
                    style = "minimal",
                    border = { " " },
                    noautocmd = true,
                },
                update_debounce = 100,
                current_line_blame = true,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol",
                    delay = 1000,
                },
                current_line_blame_formatter_opts = {
                    relative_time = true,
                },
            })
        end
    }
    use { "tpope/vim-fugitive" }
    use {
        "tpope/vim-rhubarb",
        requires = { "tpope/vim-fugitive" },
    }
    use {
        "shumphrey/fugitive-gitlab.vim",
        requires = { "tpope/vim-fugitive" },
    }
    use { "tpope/vim-surround" }
    use { "tpope/vim-repeat" }
    use { "tpope/vim-commentary" }
    use { "arecarn/vim-diff-utils" }
    use { "PeterRincker/vim-argumentative" }
    use { "editorconfig/editorconfig-vim" }
    use { "godlygeek/tabular" }
    use {
        "klen/nvim-config-local",
        config = function()
            require("config-local").setup()
        end
    }
    use { "chrisbra/NrrwRgn" }
    use { "zirrostig/vim-schlepp" }
    use { "bluz71/vim-moonfly-colors" }
    use { "vim-airline/vim-airline" }
    use {
        "vim-airline/vim-airline-themes",
        requires = { "vim-airline/vim-airline" },
    }
    vim.cmd [[colorscheme moonfly]]
end)

require("lsp")

