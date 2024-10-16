require "user.options"

vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

require "user.lazy"

-- To load all integrations at once
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. v)
end

require "user.keymaps"
require "user.whichkey"
require "user.treesitter"
require "user.better_escape"
require "user.cmp"
require "user.lua_snippets"
require "user.lsp_config"
require "user.mini"
require "user.dap_servers"
require "user.dap_ui"
require "user.git"
require "user.autocmd"

vim.g.vimtex_view_general_viewer = 'zathura'
