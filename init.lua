vim.g.mapleader = " "

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.hidden = true
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.joinspaces = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.shiftround = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  use {
    "ms-jpq/coq_nvim",
    branch = "coq",
  }
  use {
    "ms-jpq/coq.artifacts",
    branch = "artifacts",
    requires = { "ms-jpq/coq_nvim" },
  }
  use {
    "ms-jpq/coq.thirdparty",
    branch = "3p",
    requires = { "ms-jpq/coq_nvim" },
  }
  use {
    "ms-jpq/chadtree",
    branch = "chad",
    run = "python -m chadtree deps",
  }
  use { "lifepillar/vim-solarized8" }
  vim.cmd [[colorscheme solarized8]]
end)

