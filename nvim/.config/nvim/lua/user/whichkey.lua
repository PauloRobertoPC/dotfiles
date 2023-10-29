local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local optsv = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    ["b"] = { "<cmd> BufferLinePick<cr>", "Buffer Picker" },
    g = {
        name = "Git",
        j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Previous Hunk" },
        l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "B[l]ame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "[p]review Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "[r]eset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "[R]eset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "[s]tage Hunk" },
        u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "[u]ndo Stage Hunk", },
        f = { "<cmd>Telescope git_status<cr>", "Open changed [f]ile" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout [b]ranch" },
        c = { "<cmd>Telescope git_commits<cr>", " Checkout [c]ommit" },
        d = { "<cmd>Gitsigns diffthis HEAD<cr>", "[d]iff", },
    },
    l = { 
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code [A]ction"},
        D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to [D]eclaration"},
        d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to [d]efinition"},
        i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to [i]mplementation"},
        t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to [t]ype definition"},
        r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Go to [r]eferences"},
        R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "[R]ename"},
        h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "[h]over Documentation"},
        H = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "[H]over Signature Documentation"},
        f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "[f]ormat"},
    },
    -- All setted in 'treesitter.lua' file
    t = { name = "Treesitter",},
    f = {
        name = "Find",
        f = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes'))<cr>", "Find files" },
        g = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
    },
    d = {
        name = "Debug",
        a = { "<cmd>lua require'dap'.continue()<CR>", "Continue" },
        b = { "<cmd>lua require'dap'.step_over()<CR>", "Step Over" },
        c = { "<cmd>lua require'dap'.step_into()<CR>", "Step Into" },
        d = { "<cmd>lua require'dap'.step_out()<CR>", "Step Out" },
        e = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
        f = { "<cmd>lua require('dapui').toggle()<CR>", "Toggle DAP UI" },
    },
    o = {
        name = "Open",
        e = { "<cmd>Neotree toggle<cr>", "Toggle Explorer Tree" },
        l = { "<cmd>VimtexCompile<cr>", "Latex" },
        m = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown" },
        o = { "<cmd>SymbolsOutline<cr>", "Toggle Outline" },
        p = { "<cmd>TSPlaygroundToggle<cr>", "Toggle Treesitter Playground" },
        t = { "<cmd>TodoQuickFix<cr>", "Open Todo Quickfix" },
    },
    c = {
        name = "Colors",
        c = {"<cmd>CccConvert<cr>", "Convert"},
        p = {"<cmd>CccPick<cr>", "Pick Color"},
        s = {"<cmd>CccHighlighterToggle<cr>", "Show/Hide Colors"},
    },
    [""] = {
        ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
        ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment" },
    },
}

local mappingsv = {
    ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(mappingsv, optsv)
