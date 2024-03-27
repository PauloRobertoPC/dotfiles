local ls = require("luasnip") --{{{
local exp_conds = require("luasnip.extras.conditions.expand")

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

--j
--
-- End Refactoring --

-- Start Condition --
local inside_X_dolar = function(X)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1], cursor[2]
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local tot_lines = #lines
    local odd, even = nil, nil
    local parity = 0
    local flag = true
    local x, y
    for i = 1, tot_lines, 1 do 
        if not flag then
            break
        end
        local tot_char = #lines[i]
        x = 1
        while x <= tot_char and flag do
            y = x
            while lines[i]:sub(y, y) == '$' and y <= tot_char do
                y = y+1
            end
            if y-x == X then
                parity = 1 - parity
                if parity == 1 then
                    odd = {i, x, y-1}
                else
                    even = {i, x, y-1}
                end
                if i > row or (i == row and x > col) then
                    flag = false
                    break
                end
            end
            x = x + math.max(1, y-x)
        end
    end
    local after_left, before_right = false, false
    if parity == 0 and even then
        after_left = odd[1] < row or (odd[1] == row and odd[3] <= col)
        before_right = even[1] > row or (even[1] == row and even[2] >= col)
    end
    return after_left and before_right
end

local inside_single_dolar = function()
    return inside_X_dolar(1)
end

local inside_double_dolar = function()
    return inside_X_dolar(2)
end

local outside_dolar = function()
    return true
    -- return not inside_X_dolar(1) and not inside_X_dolar(2)
end

-- m -> insert when it's inside of $
-- M -> insert when it's inside of $$
-- T -> insert when it's not inside of $ and $$
local m = require("luasnip.extras.conditions").make_condition(inside_single_dolar)
local M = require("luasnip.extras.conditions").make_condition(inside_double_dolar)
local T = require("luasnip.extras.conditions").make_condition(outside_dolar)
-- End Conditions --

-- Start Markdown -- 

local highlight = s({trig="**", condition=T},fmt([[**{}**]],{i(1,"text")}))
table.insert(autosnippets, highlight)

-- End Markdown -- 

-- Start Mathjax -- 

local math_line = s(
    {
        trig="ml",
        condition = T
    },
    fmt(
        [[ 
            ${}${}
        ]], 
        {
            i(1, "math"),
            i(2, ""),
            
        }
    )
)
table.insert(autosnippets, math_line)

local math_multline = s(
    {
        trig="mm",
        condition = T,
    },
    fmt(
        [[ 
            $$
               {} 
           $$
        ]], 
        {
            i(1, "math"),
        }
    )
)
table.insert(autosnippets, math_multline)

-- Arithmetic
local pw = s({trig="([^%s]+)pw",regTrig=true,condition=m+M},
    fmt([[{}^{{{}}}]],{f(function(_, snip) return snip.captures[1] end),i(1,""),}))
table.insert(autosnippets, pw)
local sq = s({trig="sq", condition=m+M},fmt([[\sqrt{{{}}}]],{i(1,"")}))
table.insert(autosnippets, sq)
local ud = s({trig="([^%s]+)ud",regTrig=true,condition=m+M},
    fmt([[{}_{{{}}}]],{f(function(_, snip) return snip.captures[1] end),i(1,""),}))
table.insert(autosnippets, ud)

-- Greek letters
local alpha = s({trig="@a", condition=m+M},fmt([[\alpha]],{}))
local Alpha = s({trig="@A", condition=m+M},fmt([[\alpha]],{}))
table.insert(autosnippets, alpha)
table.insert(autosnippets, Alpha)
local beta = s({trig="@b", condition=m+M},fmt([[\beta]],{}))
local Beta = s({trig="@B", condition=m+M},fmt([[\beta]],{}))
table.insert(autosnippets, beta)
table.insert(autosnippets, Beta)
local chi = s({trig="@c", condition=m+M},fmt([[\chi]],{}))
local Chi = s({trig="@c", condition=m+M},fmt([[\chi]],{}))
table.insert(autosnippets, chi)
table.insert(autosnippets, Chi)
local delta = s({trig="@d", condition=m+M},fmt([[\delta]],{}))
local Delta = s({trig="@D", condition=m+M},fmt([[\Delta]],{}))
table.insert(autosnippets, delta)
table.insert(autosnippets, Delta)
local epsilon = s({trig="@e", condition=m+M},fmt([[\epsilon]],{}))
local Epsilon = s({trig="@E", condition=m+M},fmt([[\epsilon]],{}))
table.insert(autosnippets, epsilon)
table.insert(autosnippets, Epsilon)
local var_epsilon = s({trig="@ve", condition=m+M},fmt([[\varepsilon]],{}))
local Var_epsilon = s({trig="@vE", condition=m+M},fmt([[\varepsilon]],{}))
table.insert(autosnippets, var_epsilon)
table.insert(autosnippets, Var_epsilon)
local gamma = s({trig="@g", condition=m+M},fmt([[\gamma]],{}))
local Gamma = s({trig="@G", condition=m+M},fmt([[\Gamma]],{}))
table.insert(autosnippets, gamma)
table.insert(autosnippets, Gamma)
local kappa = s({trig="@k", condition=m+M},fmt([[\kappa]],{}))
local Kappa = s({trig="@K", condition=m+M},fmt([[\kappa]],{}))
table.insert(autosnippets, kappa)
table.insert(autosnippets, Kappa)
local lambda = s({trig="@l", condition=m+M},fmt([[\lambda]],{}))
local Lambda = s({trig="@L", condition=m+M},fmt([[\Lambda]],{}))
table.insert(autosnippets, lambda)
table.insert(autosnippets, Lambda)
local mu = s({trig="@m", condition=m+M},fmt([[\mu]],{}))
local Mu = s({trig="@M", condition=m+M},fmt([[\mu]],{}))
table.insert(autosnippets, mu)
table.insert(autosnippets, Mu)
local omega = s({trig="@o", condition=m+M},fmt([[\omega]],{}))
local Omega = s({trig="@O", condition=m+M},fmt([[\Omega]],{}))
table.insert(autosnippets, omega)
table.insert(autosnippets, Omega)
local rho = s({trig="@r", condition=m+M},fmt([[\rho]],{}))
local Rho = s({trig="@R", condition=m+M},fmt([[\rho]],{}))
table.insert(autosnippets, rho)
table.insert(autosnippets, Rho)
local sigma = s({trig="@s", condition=m+M},fmt([[\sigma]],{}))
local Sigma = s({trig="@S", condition=m+M},fmt([[\Sigma]],{}))
table.insert(autosnippets, sigma)
table.insert(autosnippets, Sigma)
local theta = s({trig="@t", condition=m+M},fmt([[\theta]],{}))
local Theta = s({trig="@T", condition=m+M},fmt([[\Theta]],{}))
table.insert(autosnippets, theta)
table.insert(autosnippets, Theta)
local upsilon = s({trig="@u", condition=m+M},fmt([[\upsilon]],{}))
local Upsilon = s({trig="@U", condition=m+M},fmt([[\Upsilon]],{}))
table.insert(autosnippets, upsilon)
table.insert(autosnippets, Upsilon)
local zeta = s({trig="@z", condition=m+M},fmt([[\zeta]],{}))
local Zeta = s({trig="@Z", condition=m+M},fmt([[\Zeta]],{}))
table.insert(autosnippets, zeta)
table.insert(autosnippets, Zeta)

-- Set
local bb = s({trig="bb", condition=m+M},fmt([[\mathbb{{{}}}]],{i(1,"")}))
table.insert(autosnippets, bb)
local dots = s({trig="dots", condition=m+M},fmt([[\dots]],{}))
table.insert(autosnippets, dots)
local eset = s({trig="eset", condition=m+M},fmt([[\emptyset]],{}))
table.insert(autosnippets, eset)
local in_set = s({trig="in", condition=m+M},fmt([[\in]],{}))
table.insert(autosnippets, in_set)
local notin = s({trig="notin", condition=m+M},fmt([[\not \in]],{}))
table.insert(autosnippets, notin)
local sand = s({trig="sand", condition=m+M},fmt([[\cap]],{}))
table.insert(autosnippets, sand)
local set = s({trig="set", condition=m+M},fmt([[\{{{}\}}]],{i(1,"")}))
table.insert(autosnippets, set)
local sor = s({trig="sor", condition=m+M},fmt([[\cup]],{}))
table.insert(autosnippets, sor)

-- Symbols
local infinity = s({trig="ooo", condition=m+M},fmt([[\infty]],{}))
table.insert(autosnippets, infinity)
local lim = s({trig="lim", condition=m+M},fmt([[\lim_{{{} \to {}}}]],{i(1,"x"),i(2,"\\infty")}))
table.insert(autosnippets, lim)
local prod = s({trig="prod", condition=m+M},fmt([[\prod_{{{}}}^{{{}}}]],{i(1,""),i(2,"")}))
table.insert(autosnippets, prod)
local sum = s({trig="sum", condition=m+M},fmt([[\sum_{{{}}}^{{{}}}]],{i(1,""),i(2,"")}))
table.insert(autosnippets, sum)

-- End Mathjax -- 

return snippets, autosnippets
