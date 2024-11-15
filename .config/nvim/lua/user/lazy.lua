local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    -- Used in another plugins 
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { 'MunifTanjim/nui.nvim' },
    { 'kyazdani42/nvim-web-devicons' },

    -- Snippets
    { "L3MON4D3/LuaSnip", version = "2.*", build = "make install_jsregexp" },

    -- Completion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lsp" },

    -- LSP
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    { "simrat39/symbols-outline.nvim" },
    { "ray-x/lsp_signature.nvim" },
    { "mfussenegger/nvim-jdtls" },

    -- DAP
    { 'mfussenegger/nvim-dap' },
    { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
    { 'mfussenegger/nvim-dap-python' },

    -- Navigation
    { 'nvim-telescope/telescope.nvim', dependencies = {'nvim-lua/plenary.nvim'} },
    { "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" } },

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter" },
    { 'nvim-treesitter/playground' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },

    -- UI
    {
        "nvchad/ui",
        config = function()
            require "nvchad" 
        end
    },
    {
        "nvchad/base46",
        lazy = true,
        build = function()
            require("base46").load_all_highlights()
        end,
    },

    -- Mini
    { 'echasnovski/mini.files', version = false },          -- Tree Eplorer
    { 'echasnovski/mini.animate', version = false },        -- Animate
    { 'echasnovski/mini.cursorword', version = false },     -- Cursor Word Highlight
    { 'echasnovski/mini.surround', version = false },       -- Surround

    -- -- Rainbow Parentheses
    { "HiPhish/rainbow-delimiters.nvim" },

    -- Blank Indentation Line
    -- configuration of this plugin is in treesitter
    { "lukas-reineke/indent-blankline.nvim", main = "ibl"},
    {
      "shellRaining/hlchunk.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("hlchunk").setup({
            chunk = {
                enable = true,
                style = "#806d9c",
                duration = 200,
                delay = 100,
            },
        })
      end
    },

    -- Which Key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },

    -- Comments
    { 'numToStr/Comment.nvim', opts = {} },

    -- Todo comments
    { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },

    -- Better Escape
    {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup({
                mappings = {
                    i = {
                        k = {
                            k = "<Esc>",
                            j = "<Esc>",
                        },
                    },
                }
            })
        end,
    },

    -- Latex Compiler
    { 'lervag/vimtex' },
    -- Markdown Compiler
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    -- Nvim + Tmux/Zellij/Wezterm
    {
        'dynamotn/Navigator.nvim',
        config = function()
            require('Navigator').setup()
        end
    },
    {
        "hiasr/vim-zellij-navigator.nvim",
        config = function()
            require('vim-zellij-navigator').setup()
        end
    },

    -- Git
    { 'lewis6991/gitsigns.nvim', opts = {} },

    -- Colors
    { "nvchad/volt", lazy = true },
    { "nvchad/minty", lazy = true },

}, {
    install = {
        colorscheme = { "nvchad" },
    },
})
