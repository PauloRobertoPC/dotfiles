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
    { "utilyre/barbecue.nvim", name = "barbecue", version = "*", dependencies = { "SmiteshP/nvim-navic"}, opt={} },

    -- DAP
    { 'mfussenegger/nvim-dap' },
    { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
    { 'mfussenegger/nvim-dap-python' },

    -- FZF
    { 'nvim-telescope/telescope.nvim', dependencies = {'nvim-lua/plenary.nvim'} },

    -- Treesitter
    { "nvim-treesitter/nvim-treesitter" },
    { 'nvim-treesitter/playground' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },

    -- Colorschemes
    { "catppuccin/nvim", name = "catppuccin", priority = 1000, },
    { 'projekt0n/github-nvim-theme' },
    { 'maxmx03/fluoromachine.nvim' },

    -- Status Line
    { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons'}, after={"catppuccin/nvim"}, event = 'VeryLazy', opts = true, },

    -- Tree Explorer
    { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" } },

    -- -- Rainbow Parentheses
    { "HiPhish/rainbow-delimiters.nvim" },

    -- Bufferline
    {'akinsho/bufferline.nvim', version = "*"},

    -- Blank Indentation Line
    -- configuration of this plugin is in treesitter
    { "lukas-reineke/indent-blankline.nvim", main = "ibl"},
    {
        "shellRaining/hlchunk.nvim",
        event = { "UIEnter" },
        config = function()
            require("hlchunk").setup({
                indent = {
                    chars = { "│", "¦", "┆", "┊", }, -- more code can be found in https://unicodeplus.com/
                    style = { "#8B00FF",},
                },
                blank = { enable = false,},
            })
        end
    },

    -- Smooth Scroll
    { 'karb94/neoscroll.nvim' },

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
    { "max397574/better-escape.nvim", opts = {} },

    -- Latex Compiler
    { 'lervag/vimtex' },
    -- Markdown Compiler
    { "iamcco/markdown-preview.nvim", build = "cd app && npm install" },

    -- Vim + Tmux
    { 'christoomey/vim-tmux-navigator' },

    -- Git
    { 'lewis6991/gitsigns.nvim', opts = {} },

    -- See and Pick colors in neovim
    { "uga-rosa/ccc.nvim" },

    -- Obsidian
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
                name = "my-vault",
                path = "~/Documents/Obsidian",
                },
            },
        },
    },
}, {})
