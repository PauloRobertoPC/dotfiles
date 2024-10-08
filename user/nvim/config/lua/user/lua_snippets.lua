local ls = require("luasnip") --{{{

-- require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({ paths =  "~/.config/nvim/snippets/" })
require("luasnip").config.setup({ store_selection_keys = "<A-p>" })

vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files()]]) --}}}

-- Virtual Text{{{
local types = require("luasnip.util.types")
ls.config.set_config({
    history = true, --keep around last snippet local to jump back
    updateevents = "TextChanged,TextChangedI", --update changes as you type
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "", "GruvboxOrange" } },
            },
        },
        -- [types.insertNode] = {
        -- 	active = {
        -- 		virt_text = { { "●", "GruvboxBlue" } },
        -- 	},
        -- },
    },
    store_selection_keys = "<Tab>",

}) --}}}

-- Key Mapping --{{{

-- Jump to the previous field
vim.keymap.set({ "i", "s" }, "<a-h>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end) 

vim.keymap.set({ "i", "s" }, "<a-j>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<a-k>", function()
    if ls.choice_active() then
        ls.change_choice(-1)
    end
end, { silent = true })

-- Jump to the next field
vim.keymap.set({ "i", "s" }, "<a-l>", function()
    if ls.jumpable(1) then
        ls.jump(1)
    end
end)

--}}}

-- More Settings --

vim.keymap.set("n", "<Leader><CR>", "<cmd>LuaSnipEdit<cr>", { silent = true, noremap = true })
vim.cmd([[autocmd BufEnter */snippets/*.lua nnoremap <silent> <buffer> <CR> /-- End Refactoring --<CR>O<Esc>O]])
