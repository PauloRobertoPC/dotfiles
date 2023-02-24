require("monokai-pro").setup()
require("catppuccin").setup()
require('nightfox').setup()

-- ALERT: also change the theme in lualine
-- vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
-- local colorscheme = "catppuccin"

-- ALERT: also change the theme in lualine
-- local colorscheme = "carbonfox" -- nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox

-- ALERT: also change the theme in lualine
local colorscheme = "monokai-pro"


require('lualine').setup {
  options = {
    theme = colorscheme
  }
}

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
