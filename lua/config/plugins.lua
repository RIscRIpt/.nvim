require("lazy").setup({
  spec = {
    { "neovim/nvim-lspconfig" },
    {
      "nvim-treesitter/nvim-treesitter",
      build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
      end,
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "c", "cpp", "python" },
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          incremental_selection = { enable = true },
          textobjects = { enable = true },
        })
      end
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-buffer" },
        { "f3fora/cmp-spell" },
        { "petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim" },
      },
      config = function(cmp)
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
    },
    { "ludovicchabant/vim-gutentags" },
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local telescope = require("telescope")
        local telescope_builtin = require("telescope.builtin")
        telescope.setup({
          defaults = {
            border = true,
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
              prompt_position = "top",
              horizontal = {
                width = { padding = 0 },
                height = { padding = 0 },
              },
            }
          },
        })
        vim.keymap.set("", "<leader>t", telescope_builtin.builtin)
        vim.keymap.set("", "<leader>tt", telescope_builtin.resume)
        vim.keymap.set("", "<leader>bb", telescope_builtin.buffers)
        vim.keymap.set("", "<leader>gs", telescope_builtin.git_status)
        vim.keymap.set("", "<leader>gb", telescope_builtin.git_branches)
        vim.keymap.set("", "<leader>gj", telescope_builtin.git_files)
        vim.keymap.set("", "<leader>J", telescope_builtin.oldfiles)
        vim.keymap.set("", "<leader>j", telescope.extensions.menufacture.find_files)
        vim.keymap.set("", "<leader>N", telescope.extensions.file_browser.file_browser)
        vim.keymap.set("", "<leader>n", function () telescope.extensions.file_browser.file_browser({ path = "%:p:h"}) end)
        vim.keymap.set("", "<leader>s", telescope.extensions.menufacture.live_grep)
        vim.keymap.set("v", "<leader>s", telescope.extensions.menufacture.grep_string)
      end
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("telescope").load_extension("file_browser")
      end
    },
    {
      "molecule-man/telescope-menufacture",
      dependencies = { "nvim-telescope/telescope.nvim" },
      config = function()
        require("telescope").load_extension("menufacture")
      end
    },
    {
      "ojroques/nvim-bufdel",
      config = function()
        local bufdel = require("bufdel")
        vim.keymap.set("", "<leader>bd", function() bufdel.delete_buffer_expr(vim.fn.bufnr(), false) end)
        vim.keymap.set("", "<leader>bD", function() bufdel.delete_buffer_expr(vim.fn.bufnr(), true) end)
        vim.keymap.set("", "<leader>bo", function() bufdel.delete_buffer_others(false) end)
        vim.keymap.set("", "<leader>bO", function() bufdel.delete_buffer_others(true) end)
        vim.keymap.set("", "<leader>ba", function() bufdel.delete_buffer_all(false) end)
        vim.keymap.set("", "<leader>bA", function() bufdel.delete_buffer_all(true) end)
      end
    },
    {
      "lewis6991/gitsigns.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local gs = require("gitsigns")
        gs.setup({
          signs = {
            add          = { text = nil },
            change       = { text = nil },
            delete       = { text = nil },
            topdelete    = { text = nil },
            changedelete = { text = nil },
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
    },
    { "tpope/vim-fugitive" },
    {
      "tpope/vim-rhubarb",
      dependencies = { "tpope/vim-fugitive" },
    },
    {
      "shumphrey/fugitive-gitlab.vim",
      dependencies = { "tpope/vim-fugitive" },
    },
    { "akinsho/toggleterm.nvim", version = "*", config = true },
    {
      "stevearc/dressing.nvim",
      opts = {},
    },
    { "rcarriga/nvim-notify" },
    {
      "stevearc/overseer.nvim",
      opts = {},
      dependencies = {
        "stevearc/dressing.nvim",
        "nvim-telescope/telescope.nvim",
        "rcarriga/nvim-notify",
      },
    },
    {
      "Civitasv/cmake-tools.nvim",
      opts = {},
      dependencies = {
        "nvim-lua/plenary.nvim",
        "akinsho/toggleterm.nvim",
        "stevearc/overseer.nvim",
      },
    },
    { "mbbill/undotree" },
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },
    { "tpope/vim-commentary" },
    { "arecarn/vim-diff-utils" },
    { "PeterRincker/vim-argumentative" },
    { "editorconfig/editorconfig-vim" },
    { "godlygeek/tabular" },
    {
      "klen/nvim-config-local",
      config = function()
        require("config-local").setup()
      end
    },
    { "zirrostig/vim-schlepp" },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      config = function()
        require("catppuccin").setup()
        vim.cmd.colorscheme("catppuccin")
      end
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
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
    },
    {
      "epwalsh/obsidian.nvim",
      version = "*",
      lazy = true,
      ft = "markdown",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      opts = {
        workspaces = {
          {
            name = "Personal",
            path = "~/projects/personal-docs",
          },
          {
            name = "Zimperium",
            path = "~/projects/zmpr-rdzenis-docs",
          },
        },
      },
    },
  },
})
