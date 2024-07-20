local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup {
    ensure_installed = {"c", "cpp", "rust", "python", "java", "javascript", "lua", "html", "css", "latex", "markdown"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = true, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "" }, -- List of parsers to ignore installing
    autopairs = {
        enable = true,
    },
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "python" } },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<space>tw',
            node_incremental = '<space>tw',
            scope_incremental = '<space>ts',
            node_decremental = '<space>tb',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ['<space>tf'] = '@function.outer',
                ['<space>tcf'] = '@class.outer',
            },
            goto_next_end = {
                ['<space>tt'] = '@function.outer',
                ['<space>tct'] = '@class.outer',
            },
            goto_previous_start = {
                ['<space>tF'] = '@function.outer',
                ['<space>tcF'] = '@class.outer',
            },
            goto_previous_end = {
                ['<space>tT'] = '@function.outer',
                ['<space>tcT'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>ts'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>tS'] = '@parameter.inner',
            },
        },
    },
}



-- indent-blankline configuration
-- vim.opt.listchars:append "space:."
-- vim.opt.listchars:append "eol:↴"

require("ibl").setup {
}
