local cmp = require("cmp")
local luasnip = require("luasnip")

--   פּ ﯟ   some other good icons
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    --mapping = {
    --    ["<C-p>"] = cmp.mapping.select_prev_item(),
    --    ["<C-n>"] = cmp.mapping.select_next_item(),
    --    ["<A-o>"] = cmp.mapping.select_prev_item(),
    --    ["<A-i>"] = cmp.mapping.select_next_item(),
    --    ["<A-u>"] = cmp.mapping.confirm({ select = true }),
    --    ["<C-e>"] = cmp.mapping({
    --        i = cmp.mapping.abort(),
    --        c = cmp.mapping.close(),
    --    }),
    --    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    --    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    --},
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
                copilot = "[Copilot]",
                luasnip = "LuaSnip",
                nvim_lua = "[NVim Lua]",
                nvim_lsp = "[LSP]",
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = "luasnip" },
        { name = "copilot" },
        { name = "nvim_lsp", max_item_count = 6 },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "buffer", max_item_count = 6 },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },

})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
            { name = 'cmdline' }
        })
})
