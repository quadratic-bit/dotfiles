return require("packer").startup(function()
  -- Appearance
  use "EdenEast/nightfox.nvim"
  use "feline-nvim/feline.nvim"
  use "nanozuki/tabby.nvim"
  use "karb94/neoscroll.nvim"
  use { "catppuccin/nvim", as = "catppuccin-macchiato" }

  -- Utilities
  use { "kyazdani42/nvim-tree.lua", requires = { "kyazdani42/nvim-web-devicons" } }
  use { "nvim-treesitter/nvim-treesitter", run = function() require("nvim-treesitter.install").update({ with_sync = true }) end }
  use "leafoftree/vim-svelte-plugin"
  use "jiangmiao/auto-pairs"
  use "ap/vim-css-color"
  use "lambdalisue/suda.vim"
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = [[ cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release &&
             cmake --build build --config Release &&
             cmake --install build --prefix build ]] }
  use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } }
  use "ggandor/leap.nvim"
  use "tpope/vim-surround"
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- Completion and other
  use { "neoclide/coc.nvim", branch = "master", run = "yarn install" }
  use "plasticboy/vim-markdown"
  use "mattn/emmet-vim"

  -- Git
  use "airblade/vim-gitgutter"
end)
