vim.cmd("source " .. vim.fn.stdpath("config") .. "/settings.vim")
vim.cmd("packadd packer.nvim")

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
  use { "tpope/vim-surround" }
  use { "tpope/vim-repeat" }
  use { "tpope/vim-commentary" }
  use { "godlygeek/tabular" }
  use { "chrisbra/NrrwRgn" }
  use { "zirrostig/vim-schlepp" }
  use { "lifepillar/vim-solarized8" }
  use { "vim-airline/vim-airline" }
  use {
    "vim-airline/vim-airline-themes",
    requires = { "vim-airline/vim-airline" },
  }
  vim.cmd [[colorscheme solarized8]]
end)

