vim.cmd("packadd packer.nvim")

require("packer").startup(function(use)
    use { "neovim/nvim-lspconfig" }
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "cpp", "python" },
                highlight = {
                    enable = false,
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = { enable = true },
                textobjects = { enable = true },
            })
        end
    }
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-buffer" },
            { "f3fora/cmp-spell" },
            { "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" },
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "spell" },
                    { name = "git" },
                    { name = "buffer" },
                }),
                mapping = {
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                },
            })
        end
    }
    use { "ludovicchabant/vim-gutentags" }
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
        "molecule-man/telescope-menufacture",
        requires = { { "nvim-telescope/telescope.nvim" } },
        config = function()
            require("telescope").load_extension("menufacture")
        end
    }
    use { "ojroques/nvim-bufdel" }
    use {
        "lewis6991/gitsigns.nvim",
        requires = { { "nvim-lua/plenary.nvim" } },
        config = function()
            local gs = require("gitsigns")
            gs.setup({
                signs = {
                    add          = { hl = "GitSignsAdd",    text = nil, numhl = "GitSignsAddNr",    linehl = "GitSignsAddLn" },
                    change       = { hl = "GitSignsChange", text = nil, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
                    delete       = { hl = "GitSignsDelete", text = nil, numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                    topdelete    = { hl = "GitSignsDelete", text = nil, numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
                    changedelete = { hl = "GitSignsChange", text = nil, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
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
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol",
                    delay = 1000,
                },
                current_line_blame_formatter_opts = {
                    relative_time = true,
                },
            })

            vim.keymap.set("n", "]c", function()
                if vim.wo.diff then return "]c" end
                vim.schedule(function() gs.next_hunk() end)
                return "<Ignore>"
            end, { expr = true })
            vim.keymap.set("n", "[c", function()
                if vim.wo.diff then return "[c" end
                vim.schedule(function() gs.prev_hunk() end)
                return "<Ignore>"
            end, { expr = true })

            vim.keymap.set("n", "<leader>hs", gs.stage_hunk)
            vim.keymap.set("v", "<leader>hs", function() gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end)
            vim.keymap.set("n", "<leader>hr", gs.reset_hunk)
            vim.keymap.set("v", "<leader>hr", function() gs.reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end)
            vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk)
            vim.keymap.set("n", "<leader>hR", gs.reset_buffer)
            vim.keymap.set("n", "<leader>hp", gs.preview_hunk)
            vim.keymap.set("n", "<leader>hb", function() gs.blame_line({full = true}) end)
            vim.keymap.set("n", "<leader>hS", gs.stage_buffer)
            vim.keymap.set("n", "<leader>hU", gs.reset_buffer_index)
            vim.keymap.set("n", "<leader>hd", gs.diffthis)
            vim.keymap.set("n", "<leader>hD", function() gs.diffthis("~") end)
            vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame)
            vim.keymap.set("n", "<leader>gd", gs.toggle_deleted)
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
    use { "mbbill/undotree" }
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
    use { "zirrostig/vim-schlepp" }
    use { "bluz71/vim-moonfly-colors" }
    use { "catppuccin/nvim", as = "catppuccin" }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            local buffers = require("lualine.components.buffers")
            function buffer_jump_fn(nr)
                return function() buffers.buffer_jump(nr, "!") end
            end
            for i = 1,9 do
                vim.keymap.set("", "<leader>" .. i, buffer_jump_fn(i))
            end
            vim.keymap.set("", "<leader>0", buffer_jump_fn(10))
            require("lualine").setup({
                options = {
                    theme = "catppuccin"
                },
                tabline = {
                    lualine_a = {{
                        "buffers",
                        mode = 2,
                    }},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {"tabs"},
                },
            })
        end
    }
end)

require("utils")
require("settings")
require("lsp")
