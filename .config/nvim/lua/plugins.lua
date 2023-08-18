return require("packer").startup(function()
  -- Packer minding its buisness
  use "wbthomason/packer.nvim"

  -- Appearance
  use "feline-nvim/feline.nvim"
  use "nanozuki/tabby.nvim"
  use {
    "karb94/neoscroll.nvim",
    config = function ()
      require"neoscroll".setup()
    end
  }
  use { "catppuccin/nvim", as = "catppuccin-macchiato" }

  -- LSP and completion
  use {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    requires = {
      -- LSP Support
      {"neovim/nvim-lspconfig"},
      {"williamboman/mason.nvim"},
      {"williamboman/mason-lspconfig.nvim"},

      -- Autocompletion
      {"hrsh7th/nvim-cmp"},
      {"hrsh7th/cmp-buffer"},
      {"hrsh7th/cmp-path"},
      {"hrsh7th/cmp-nvim-lsp"},
      {"hrsh7th/cmp-nvim-lua"},
      {"L3MON4D3/LuaSnip"},
      {"saadparwaiz1/cmp_luasnip"},
    }
  }
  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup{}
    end
  }

  -- Utilities
  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons"
    }
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end
  }
  use "nvim-treesitter/nvim-treesitter-context"
  use "jiangmiao/auto-pairs"
  use "ap/vim-css-color"
  use "lambdalisue/suda.vim"
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = [[ cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release &&
    cmake --build build --config Release &&
    cmake --install build --prefix build ]] }
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim"
      }
    }
    use "ggandor/leap.nvim"
    use "tpope/vim-surround"
    use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    })
    use "ledger/vim-ledger"
    use "plasticboy/vim-markdown"
    use "airblade/vim-gitgutter"
  end)
