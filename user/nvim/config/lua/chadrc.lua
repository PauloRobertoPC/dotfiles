local M = {}

M.base46 = {
    theme = "catppuccin",
    theme_toggle = { "catppuccin", "everforest_light", },
    integrations = { "cmp", "dap", "lsp", "telescope",  "rainbowdelimiters", "treesitter", "todo", "trouble", "whichkey", },
}

M.ui = {
    statusline = { 
        theme = "default",
        separator_style = "default",
    },

    cmp = {
        style = "atom",
    }
}
return M
