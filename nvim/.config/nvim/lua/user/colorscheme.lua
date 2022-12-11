require("catppuccin").setup()
require('nightfox').setup()

-- local colorscheme = "darkplus"

-- local colorscheme = "onedarker"

-- local colorscheme = "tokyodark" 
 
-- local colorscheme = "tundra" 
 
-- ALERT: also change the theme in lualine
-- vim.g.tokyonight_style = "night" -- night, storm, day
-- local colorscheme = "tokyonight"

-- ALERT: also change the theme in lualine
-- vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
-- local colorscheme = "catppuccin"

local colorscheme = "carbonfox" -- nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
