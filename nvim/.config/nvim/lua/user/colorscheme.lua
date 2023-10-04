require("catppuccin").setup()

-- ALERT: also change the theme in lualine
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
local colorscheme = "catppuccin"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

require('lualine').setup {
    options = {
        theme = colorscheme
    }
}

if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
