local ls = require("luasnip") --{{{
local s = ls.s  -- snippet
local i = ls.i  -- insert node
local t = ls.t  -- text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.lua"

local function cs(trigger, nodes, opts) --{{{
    local snippet = s(trigger, nodes)
    local target_table = snippets

    local pattern = file_pattern
    local keymaps = {}

    if opts ~= nil then
        -- check for custom pattern
        if opts.pattern then
            pattern = opts.pattern
        end

        -- if opts is a string
        if type(opts) == "string" then
            if opts == "auto" then
                target_table = autosnippets
            else
                table.insert(keymaps, { "i", opts })
            end
        end

        -- if opts is a table
        if opts ~= nil and type(opts) == "table" then
            for _, keymap in ipairs(opts) do
                if type(keymap) == "string" then
                    table.insert(keymaps, { "i", keymap })
                else
                    table.insert(keymaps, keymap)
                end
            end
        end

        -- set autocmd for each keymap
        if opts ~= "auto" then
            for _, keymap in ipairs(keymaps) do
                vim.api.nvim_create_autocmd("BufEnter", {
                    pattern = pattern,
                    group = group,
                    callback = function()
                        vim.keymap.set(keymap[1], keymap[2], function()
                            ls.snip_expand(snippet)
                        end, { noremap = true, silent = true, buffer = true })
                    end,
                })
            end
        end
    end

    table.insert(target_table, snippet) -- insert snippet into appropriate table
end --}}}

-- Start Refactoring --

local myFirstSnip = s("myFirstSnip", {t("Hi, this is my first snippet!")})

local text_node = s("text_node", {t("Hi, this is my first snippet!")})

local insert_node = s("insert_node", {
    t("Hello this is a text_node "),
    i(1, "place_holder"),
    t({"new_line", "This is another text node"}),
})

local format_snip = s("format_snip", 
    fmt([[ 
        local {} = function({})
            {} -- {{Writing inside '{{}}'}}
        end
]], 
        {
            i(1, "My Name"),
            i(2, "My Args"),
            i(3, "My Body"),
        }
    )
)

local choice_node = s("choice_node", 
    fmt([[ 
        local {} = function({})
            {} -- {{Writing inside '{{}}'}}
        end
]], 
        {
            i(1, "My Name"),
            i(2, "My Args"),
            c(3, { t("My Body"), t("My Rules"), i(1, "My choices")}),
        }
    )
)

local auto_snip = s("auto_snip", { t("This was auto trigerred")})
local auto_snip_regex = s({trig = "auto%d%d", regTrig = true}, { t("This was auto trigerred")})

local function_snip = s({trig = "func(%d%d)(%d)", regTrig = true}, { 
    f(function(_, snip)
        return snip.captures[1] .. " and "
    end),
    f(function(_, snip)
        return snip.captures[2] .. " cool! for more see lua regex."
    end),
})

local function_snip_arg = s({trig = "funcargs", regTrig = true}, { 
    i(1, "first argument"),
    f(function(arg, snip)
        return arg[1][1] .. " X " .. arg[2][1]
    end, {1, 2}),
    i(2, "second argument"),
})

local replicate = s("rep", {
    i(1, "Type Something"),
    t(" REPEATED TEXT: "),
    rep(1),
})


table.insert(snippets, myFirstSnip)
table.insert(snippets, text_node)
table.insert(snippets, insert_node)
table.insert(snippets, format_snip)
table.insert(snippets, choice_node)
table.insert(autosnippets, auto_snip)
table.insert(autosnippets, auto_snip_regex)
table.insert(autosnippets, function_snip)
table.insert(autosnippets, function_snip_arg)
table.insert(snippets, replicate)

-- End Refactoring --

--Dynamic Node **** Use alt+p to triger it
cs( -- for([%w_]+) JS For Loop snippet{{{
	{ trig = "for([%w_]+)", regTrig = true, hidden = true },
	fmt(
		[[
for (let {} = 0; {} < {}; {}++) {{
  {}
}}
{}
    ]],
		{
			d(1, function(_, snip)
				return sn(1, i(1, snip.captures[1]))
			end),
			rep(1),
			c(2, { i(1, "num"), sn(1, { i(1, "arr"), t(".length") }) }),
			rep(1),
			i(3, "// TODO:"),
			i(4),
		}
	)
) --}}}

return snippets, autosnippets
