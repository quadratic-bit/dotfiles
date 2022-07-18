return require('packer').startup(function()
  -- Appearance
  use "EdenEast/nightfox.nvim"
  use "feline-nvim/feline.nvim"
  use "nanozuki/tabby.nvim"
  use "karb94/neoscroll.nvim"

  -- Utilities
  use { "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" } }
  use "sheerun/vim-polyglot"
  use "leafoftree/vim-svelte-plugin"
  use "jiangmiao/auto-pairs"
  use "ap/vim-css-color"
  use "lambdalisue/suda.vim"

  -- Completion and other
  use { "neoclide/coc.nvim", branch = "master", run = "yarn install" }
  use "plasticboy/vim-markdown"
  use "mattn/emmet-vim"

  -- Git
  use "airblade/vim-gitgutter"
end)
