-- vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
-- local colorscheme = "catppuccin"

-- local colorscheme = "github_dark_high_contrast" -- github_dark, github_dark_dimmed, github_dark_high_contrast, github_dark_colorblind, github_dark_tritanopia, github_light, github_light_high_contrast, github_light_colorblind, github_light_tritanopia

local colorscheme = "retrowave" -- fluoromachine, retrowave, delta

require("catppuccin").setup()
require('github-theme').setup({})
require('fluoromachine').setup({ glow = false, theme = colorscheme })

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
