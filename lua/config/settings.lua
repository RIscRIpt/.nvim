table.unpack = table.unpack or unpack -- 5.1 compatibility

vim.cmd.syntax("on")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local data_dir = vim.fn.stdpath("data")
vim.o.backupdir = vim.fn.expand(data_dir .. "/backup//")
vim.o.directory = vim.fn.expand(data_dir .. "/swap//")
vim.o.undodir = vim.fn.expand(data_dir .. "/undo//")
vim.o.viewdir = vim.fn.expand(data_dir .. "/view//")
vim.g.gutentags_cache_dir = vim.fn.expand(data_dir .. "/tags//")

vim.opt.backup = true
vim.opt.writebackup = true
vim.opt.swapfile = true
vim.opt.undofile = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.opt.conceallevel = 1
vim.opt.formatoptions = "tcro/qnjp"
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.listchars = "tab:¦ ,trail:·,nbsp:░,extends:»,precedes:«"
vim.opt.lazyredraw = true
vim.opt.mouse = "a"
vim.opt.shortmess = "aIcOt"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.spell = true
vim.opt.spelllang = "en,ru,lv"
vim.opt.grepprg = "rg"
vim.opt.showbreak = "↳"
vim.opt.winblend = 10

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

if not vim.fn.has("macunix") then
  vim.keymap.set("i", "<c-v>", "<s-insert>")
  vim.keymap.set("v", "<c-c>", "<c-insert>")
end

vim.keymap.set("", "<c-s>", "<cmd>up<cr>")
vim.keymap.set("i", "<c-s>", "<c-o><cmd>up<cr>")

vim.keymap.set("n", "<f7>", "<cmd>make<cr>")

vim.keymap.set("n", "<leader><leader>", "<cmd>b#<cr>")
vim.keymap.set("v", "<leader><leader>", "<cmd>b#<cr>")

if not vim.fn.has("macunix") then
  vim.keymap.set("", "<A-=>", "<C-w>=", { silent = true })
  vim.keymap.set("", "<A-j>", "<C-w>-", { silent = true })
  vim.keymap.set("", "<A-k>", "<C-w>+", { silent = true })
  vim.keymap.set("", "<A-h>", "<C-w><", { silent = true })
  vim.keymap.set("", "<A-l>", "<C-w>>", { silent = true })
  vim.keymap.set("", "<A-w>", "<C-w><C-w>", { silent = true })
  vim.keymap.set("", "<A-q>", "<C-w><S-w>", { silent = true })
else
  vim.keymap.set("", "≠", "<C-w>=", { silent = true })
  vim.keymap.set("", "∆", "<C-w>-", { silent = true })
  vim.keymap.set("", "˚", "<C-w>+", { silent = true })
  vim.keymap.set("", "˙", "<C-w><", { silent = true })
  vim.keymap.set("", "¬", "<C-w>>", { silent = true })
  vim.keymap.set("", "∑", "<C-w><C-w>", { silent = true })
  vim.keymap.set("", "œ", "<C-w><S-w>", { silent = true })
end
vim.keymap.set("", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("", "<C-l>", "<C-w>l", { silent = true })

vim.keymap.set("n", "K", "ddpkJ")

vim.keymap.set("n", "gb", "<cmd>bn<cr>")
vim.keymap.set("n", "gB", "<cmd>bp<cr>")

vim.keymap.set("n", "<up>", "<c-y>")
vim.keymap.set("n", "<down>", "<c-e>")
vim.keymap.set("n", "<left>", "zh")
vim.keymap.set("n", "<right>", "zl")

vim.keymap.set("n", "<leader>.", "@:")

local function toggle_background()
  vim.o.background = vim.o.background == "dark" and "light" or "dark"
end
vim.keymap.set("", "<F25>", toggle_background)
vim.keymap.set("", "<C-F1>", toggle_background)

local function wipe_trailing_whitespaces()
  local view = vim.fn.winsaveview()
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.winrestview(view)
end
vim.keymap.set("n", "<leader>ww", wipe_trailing_whitespaces)
vim.keymap.set("v", "<leader>ww", wipe_trailing_whitespaces)

vim.keymap.set("v", "<S-Up>",   "<Plug>SchleppIndentUp")
vim.keymap.set("v", "<S-Down>", "<Plug>SchleppIndentDown")
vim.keymap.set("v", "<Up>",   "<Plug>SchleppUp")
vim.keymap.set("v", "<Down>",   "<Plug>SchleppDown")
vim.keymap.set("v", "<Left>",   "<Plug>SchleppLeft")
vim.keymap.set("v", "<Right>",  "<Plug>SchleppRight")
vim.keymap.set("v", "D",    "<Plug>SchleppDup")

vim.g["Schlepp#allowSquishingLines"] = 1
vim.g["Schlepp#allowSquishingBlocks"] = 1
vim.g["Schlepp#trimWS"] = 0
vim.g["Schlepp#reindent"] = 0

vim.keymap.set("n", "<leader><Tab>", ":Tabularize /")
vim.keymap.set("v", "<leader><Tab>", ":Tabularize /")

vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>", { silent = true })
vim.keymap.set("n", "<leader>gm", "<cmd>G mergetool<cr>", { silent = true })
vim.keymap.set("n", "<leader>gb", "<cmd>GBrowse<cr>", { silent = true })
vim.keymap.set("v", "<leader>gb", "<cmd>GBrowse<cr>", { silent = true })
vim.keymap.set("n", "<leader>gl", "<cmd>GBrowse!<cr>", { silent = true })
vim.keymap.set("v", "<leader>gl", "<cmd>GBrowse!<cr>", { silent = true })

vim.g["EditorConfig_exclude_patterns"] = { "fugitive://.*" }

vim.g.gutentags_enabled = false
vim.g.gutentags_generate_on_write = false

vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "GitSignsAdd" })
vim.api.nvim_set_hl(0, "GitSignsAddLn", { link = "GitSignsAddLn" })
vim.api.nvim_set_hl(0, "GitSignsAddNr", { link = "GitSignsAddNr" })
vim.api.nvim_set_hl(0, "GitSignsChange", { link = "GitSignsChange" })
vim.api.nvim_set_hl(0, "GitSignsChangeLn", { link = "GitSignsChangeLn" })
vim.api.nvim_set_hl(0, "GitSignsChangeNr", { link = "GitSignsChangeNr" })
vim.api.nvim_set_hl(0, "GitSignsChangedelete", { link = "GitSignsChange" })
vim.api.nvim_set_hl(0, "GitSignsChangedeleteLn", { link = "GitSignsChangeLn" })
vim.api.nvim_set_hl(0, "GitSignsChangedeleteNr", { link = "GitSignsChangeNr" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "GitSignsDelete" })
vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { link = "GitSignsDeleteLn" })
vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { link = "GitSignsDeleteNr" })
vim.api.nvim_set_hl(0, "GitSignsTopdelete", { link = "GitSignsDelete" })
vim.api.nvim_set_hl(0, "GitSignsTopdeleteLn", { link = "GitSignsDeleteLn" })
vim.api.nvim_set_hl(0, "GitSignsTopdeleteNr", { link = "GitSignsDeleteNr" })
