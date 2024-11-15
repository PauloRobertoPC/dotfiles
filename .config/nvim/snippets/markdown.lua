local ls = require("luasnip")

local exp_conds = require("luasnip.extras.conditions.expand")
-- require("luasnip.extras.conditions").make_condition(function)

local s = ls.s  -- snippet
local i = ls.i  -- insert node
local t = ls.t  -- text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local postfix = require("luasnip.extras.postfix").postfix

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.lua"

-- add autosnippets
local aa = function(snp)
    table.insert(autosnippets, snp)
end

local as = function(snp)
    table.insert(snippets, snp)
end

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
    return not inside_X_dolar(1) and not inside_X_dolar(2)
end

-- m -> insert when it's inside of $
-- M -> insert when it's inside of $$
-- T -> insert when it's not inside of $ and $$
local m = require("luasnip.extras.conditions").make_condition(inside_single_dolar)
local M = require("luasnip.extras.conditions").make_condition(inside_double_dolar)
local T = require("luasnip.extras.conditions").make_condition(outside_dolar)
-- End Conditions --


aa(
    s(
        {
            trig="ml",
            condition = T
        },
        fmta(
            [[ 
                $<>$<>
            ]], 
            {
                i(1, "math"),
                i(2, ""),
                
            }
        )
    )
)

aa(
    s(
        {
            trig="mm",
            condition = T,
        },
        fmta(
            [[ 
                $$
                   <>
                $$
            ]], 
            {
                i(1, "math"),
            }
        )
    )
)

-- Comparators
aa(s({trig="!=", condition=m+M},fmta([[\neq]],{})))
aa(s({trig=">=", condition=m+M},fmta([[\geq]],{})))
aa(s({trig="<=", condition=m+M},fmta([[\leq]],{})))

-- Arithmetic
aa(s({trig="([^%s]+)pw",regTrig=true,condition=m+M},
    fmta([[<>^{<>}]],{f(function(_, snip) return snip.captures[1] end),i(1,""),})))
aa(s({trig="sq", condition=m+M},fmta([[\sqrt{<>}]],{i(1,"")})))
aa(s({trig="([^%s]+)ss",regTrig=true,condition=m+M},
    fmta([[<>_{<>}]],{f(function(_, snip) return snip.captures[1] end),i(1,""),})))
aa(s({trig="//", condition=m+M},fmta([[\frac{<>}{<>}]],{i(1,""),i(2,"")})))
aa(s({trig="([%+%-%*])/", regTrig=true, condition=m+M},fmta([[<>\frac{<>}{<>}]],
    {f(function(_, snip) return snip.captures[1] end), i(1,""), i(2,"")})))
aa(s({trig="([^%s$(){}]+)/", regTrig=true, condition=m+M},fmta([[\frac{<>}{<>}]],
    {f(function(_, snip) return snip.captures[1] end), i(1,"")})))
aa(s({trig="(%b())/", regTrig=true, condition=m+M},fmta([[\frac{<>}{<>}]],
    {f(function(_, snip) return snip.captures[1]:sub(2,-2) end), i(1,"")})))

-- Greek letters
aa(s({trig=";a", condition=m+M},fmta([[\alpha]],{})))
aa(s({trig=";A", condition=m+M},fmta([[\alpha]],{})))
aa(s({trig=";b", condition=m+M},fmta([[\beta]],{})))
aa(s({trig=";B", condition=m+M},fmta([[\beta]],{})))
aa(s({trig=";c", condition=m+M},fmta([[\chi]],{})))
aa(s({trig=";c", condition=m+M},fmta([[\chi]],{})))
aa(s({trig=";d", condition=m+M},fmta([[\delta]],{})))
aa(s({trig=";D", condition=m+M},fmta([[\Delta]],{})))
aa(s({trig=";e", condition=m+M},fmta([[\epsilon]],{})))
aa(s({trig=";E", condition=m+M},fmta([[\epsilon]],{})))
aa(s({trig=";ve", condition=m+M},fmta([[\varepsilon]],{})))
aa(s({trig=";vE", condition=m+M},fmta([[\varepsilon]],{})))
aa(s({trig=";g", condition=m+M},fmta([[\gamma]],{})))
aa(s({trig=";G", condition=m+M},fmta([[\Gamma]],{})))
aa(s({trig=";k", condition=m+M},fmta([[\kappa]],{})))
aa(s({trig=";K", condition=m+M},fmta([[\kappa]],{})))
aa(s({trig=";l", condition=m+M},fmta([[\lambda]],{})))
aa(s({trig=";L", condition=m+M},fmta([[\Lambda]],{})))
aa(s({trig=";m", condition=m+M},fmta([[\mu]],{})))
aa(s({trig=";M", condition=m+M},fmta([[\mu]],{})))
aa(s({trig=";o", condition=m+M},fmta([[\omega]],{})))
aa(s({trig=";O", condition=m+M},fmta([[\Omega]],{})))
aa(s({trig=";p", condition=m+M},fmta([[\phi]],{})))
aa(s({trig=";P", condition=m+M},fmta([[\Phi]],{})))
aa(s({trig=";vp", condition=m+M},fmta([[\varphi]],{})))
aa(s({trig=";vP", condition=m+M},fmta([[\varphi]],{})))
aa(s({trig=";r", condition=m+M},fmta([[\rho]],{})))
aa(s({trig=";R", condition=m+M},fmta([[\rho]],{})))
aa(s({trig=";s", condition=m+M},fmta([[\sigma]],{})))
aa(s({trig=";S", condition=m+M},fmta([[\Sigma]],{})))
aa(s({trig=";t", condition=m+M},fmta([[\theta]],{})))
aa(s({trig=";T", condition=m+M},fmta([[\Theta]],{})))
aa(s({trig=";u", condition=m+M},fmta([[\upsilon]],{})))
aa(s({trig=";U", condition=m+M},fmta([[\Upsilon]],{})))
aa(s({trig=";z", condition=m+M},fmta([[\zeta]],{})))
aa(s({trig=";Z", condition=m+M},fmta([[\Zeta]],{})))

-- Set
aa(s({trig="bb", condition=m+M},fmta([[\mathbb{<>}]],{i(1,"")})))
aa(s({trig="dots", condition=m+M},fmta([[\dots]],{})))
aa(s({trig="eset", condition=m+M},fmta([[\emptyset]],{})))
aa(s({trig="in", condition=m+M},fmta([[\in]],{})))
aa(s({trig="notin", condition=m+M},fmta([[\not \in]],{})))
aa(s({trig="sand", condition=m+M},fmta([[\cap]],{})))
aa(s({trig="set", condition=m+M},fmta([[\{<>\}]],{i(1,"")})))
aa(s({trig="sor", condition=m+M},fmta([[\cup]],{})))
aa(s({trig="times", condition=m+M},fmta([[\times]],{})))

-- Symbols
aa(s({trig="ooo", condition=m+M},fmta([[\infty]],{})))
aa(s({trig="lim", condition=m+M},fmta([[\lim_{<> \to <>}]],{i(1,"x"),i(2,"\\infty")})))
aa(s({trig="prod", condition=m+M},fmta([[\prod_{<>}^{<>}]],{i(1,""),i(2,"")})))
aa(s({trig="sum", condition=m+M},fmta([[\sum_{<>}^{<>}]],{i(1,""),i(2,"")})))
aa(s({trig="~", condition=m+M},fmta([[\widetilde{<>}<>]],{i(1,""),i(2,"")})))


-- Arrows
aa(s({trig="<a", condition=m+M},fmta([[\leftarrow]],{})))
aa(s({trig="<A", condition=m+M},fmta([[\Leftarrow]],{})))
aa(s({trig=">a", condition=m+M},fmta([[\rightarrow]],{})))
aa(s({trig=">A", condition=m+M},fmta([[\Rightarrow]],{})))
aa(s({trig="<>a", condition=m+M},fmta([[\leftrightarrow]],{})))
aa(s({trig="<>A", condition=m+M},fmta([[\Leftrightarrow]],{})))

-- Math Fonts
aa(s({trig="(%a)%.cal", regTrig=true, condition=m+M}, {f(function(_, snip) return "\\mathcal{" .. snip.captures[1] .."}" end)}))

aa(
    postfix(".beg",
        fmta(
            [[
                \begin{<>}
                    <>
                \end{<>}
            ]],
            {
                f(function(_, parent) return parent.snippet.env.POSTFIX_MATCH end),
                i(1, ""),
                f(function(_, parent) return parent.snippet.env.POSTFIX_MATCH end),
            }
        )
    )
)

aa(s({trig="text", condition=m+M},fmta([[\text{ <> }]],{i(1,"text")})))

return snippets, autosnippets
