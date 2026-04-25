local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
        }, true, {})
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Appearance
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "nanozuki/tabby.nvim" },
    { "catppuccin/nvim", name = "catppuccin" },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl" },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- LSP
    { "neovim/nvim-lspconfig" },
    { "mason-org/mason.nvim" },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },

    -- Completion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },

    {
        "folke/trouble.nvim",
        opts = {},
    },
    { "lervag/vimtex" },
    { "andymass/vim-matchup" },

    -- Utilities
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            "neovim-treesitter/treesitter-parser-registry",
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {},
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)

            local ok_cmp, cmp = pcall(require, "cmp")
            local ok_pairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

            if ok_cmp and ok_pairs then
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end
        end,
    },
    {
        "catgoose/nvim-colorizer.lua",
        opts = {},
    },
    { "lambdalisue/suda.vim" },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = [[cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release &&
                          cmake --build build --config Release &&
                          cmake --install build --prefix build]],
            },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({})
            pcall(telescope.load_extension, "fzf")
        end,
    },
    { "tpope/vim-surround" },
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    { "ledger/vim-ledger" },
    { "airblade/vim-gitgutter" },
}, {
    install = {
        colorscheme = { "catppuccin-mocha" },
    },
    change_detection = {
        notify = false,
    },
    rocks = {
        enabled = false,
    },
})
