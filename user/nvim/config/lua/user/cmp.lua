-- local cmp = require("cmp")
-- local luasnip = require("luasnip")
--
-- --   פּ ﯟ   some other good icons
-- local kind_icons = {
--     Text = "",
--     Method = "m",
--     Function = "",
--     Constructor = "",
--     Field = "",
--     Variable = "",
--     Class = "",
--     Interface = "",
--     Module = "",
--     Property = "",
--     Unit = "",
--     Value = "",
--     Enum = "",
--     Keyword = "",
--     Snippet = "",
--     Color = "",
--     File = "",
--     Reference = "",
--     Folder = "",
--     EnumMember = "",
--     Constant = "",
--     Struct = "",
--     Event = "",
--     Operator = "",
--     TypeParameter = "",
-- }
-- -- find more here: https://www.nerdfonts.com/cheat-sheet
--
-- cmp.setup({
--     snippet = {
--         expand = function(args)
--             luasnip.lsp_expand(args.body) -- For `luasnip` users.
--         end,
--     },
--
--     mapping = cmp.mapping.preset.insert({
--         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
--         ['<C-Space>'] = cmp.mapping.complete(),
--         ['<C-e>'] = cmp.mapping.abort(),
--         ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--     }),
--     --mapping = {
--     --    ["<C-p>"] = cmp.mapping.select_prev_item(),
--     --    ["<C-n>"] = cmp.mapping.select_next_item(),
--     --    ["<A-o>"] = cmp.mapping.select_prev_item(),
--     --    ["<A-i>"] = cmp.mapping.select_next_item(),
--     --    ["<A-u>"] = cmp.mapping.confirm({ select = true }),
--     --    ["<C-e>"] = cmp.mapping({
--     --        i = cmp.mapping.abort(),
--     --        c = cmp.mapping.close(),
--     --    }),
--     --    ["<CR>"] = cmp.mapping.confirm({ select = false }),
--     --    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
--     --},
--     formatting = {
--         fields = { "kind", "abbr", "menu" },
--         format = function(entry, vim_item)
--             -- Kind icons
--             vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
--             vim_item.menu = ({
--                 copilot = "[Copilot]",
--                 luasnip = "LuaSnip",
--                 nvim_lua = "[NVim Lua]",
--                 nvim_lsp = "[LSP]",
--                 buffer = "[Buffer]",
--                 path = "[Path]",
--             })[entry.source.name]
--             return vim_item
--         end,
--     },
--     sources = {
--         { name = "luasnip" },
--         { name = "copilot" },
--         { name = "nvim_lsp", max_item_count = 100 },
--         { name = "nvim_lua" },
--         { name = "path" },
--         { name = "buffer", max_item_count = 100 },
--     },
--     confirm_opts = {
--         behavior = cmp.ConfirmBehavior.Replace,
--         select = false,
--     },
--     window = {
--         -- documentation = false,
--         documentation = {
--             -- border = "rounded",
--             -- 	-- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
--             -- winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
--         },
--         completion = {
--             -- border = "rounded",
--             -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
--         },
--     },
--
-- })
--
-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--         { name = 'buffer' }
--     }
-- })
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = cmp.config.sources({
--         { name = 'path' }
--     }, {
--             { name = 'cmdline' }
--         })
-- })


local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then return end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then return end

local check_backspace = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api
            .nvim_buf_get_lines(0, line - 1, line, true)[1]
            :sub(col, col)
            :match("%s")
        == nil
end
cmp.setup({
    completion = {
        completeopt = "menu,menuone,noinsert",
        keyword_length = 1,
    },
    preselect = cmp.PreselectMode.None,
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = require("user.icons").kinds[vim_item.kind]
            vim_item.menu = ({
                nvim_lsp = "Lsp",
                nvim_lua = "Lua",
                luasnip = "Snippet",
                buffer = "Buffer",
                path = "Path",
            })[entry.source.name]
            return vim_item
        end,
    },
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false, --[[  NOTE: test ]]
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping(
            cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            { "i", "c" }
        ),
        ["<C-j>"] = cmp.mapping(
            cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            { "i", "c" }
        ),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs( -1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-c>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable( -1) then
                luasnip.jump( -1)
            else
                fallback()
            end
        end, {
                "i",
                "s",
            }),
    }),
    sources = {
        {
            name = "nvim_lsp",
            filter = function(entry, ctx)
                local kind =
                require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
                if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                    return false
                end

                if kind == "Text" then return false end
            end,
        },
        { name = "vsnip" },
        { name = "nvim_lua" },
        { name = "luasnip", option = { use_show_condition = false } },
        { name = "buffer" },
        { name = "path" },
    },
    window = {
        -- documentation = false,
        documentation = {
            -- border = "rounded",
            -- 	-- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            -- winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
        completion = {
            -- border = "rounded",
            -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
    },
    experimental = {
        ghost_text = true,
    },
})

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
            { name = "cmdline" },
        }),
})
