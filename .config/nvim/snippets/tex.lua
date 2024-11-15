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

-- add snippets
local as = function(snp)
    table.insert(snippets, snp)
end

local get_visual = function(args, parent)
    if (#parent.snippet.env.LS_SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else  -- If LS_SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end

-- { Start Condition --
-- local inside_X_dolar = function(X)
--     local cursor = vim.api.nvim_win_get_cursor(0)
--     local row, col = cursor[1], cursor[2]
--     local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--     local tot_lines = #lines
--     local odd, even = nil, nil
--     local parity = 0
--     local flag = true
--     local x, y
--     for i = 1, tot_lines, 1 do 
--         if not flag then
--             break
--         end
--         local tot_char = #lines[i]
--         x = 1
--         while x <= tot_char and flag do
--             y = x
--             while lines[i]:sub(y, y) == '$' and y <= tot_char do
--                 y = y+1
--             end
--             if y-x == X then
--                 parity = 1 - parity
--                 if parity == 1 then
--                     odd = {i, x, y-1}
--                 else
--                     even = {i, x, y-1}
--                 end
--                 if i > row or (i == row and x > col) then
--                     flag = false
--                     break
--                 end
--             end
--             x = x + math.max(1, y-x)
--         end
--     end
--     local after_left, before_right = false, false
--     if parity == 0 and even then
--         after_left = odd[1] < row or (odd[1] == row and odd[3] <= col)
--         before_right = even[1] > row or (even[1] == row and even[2] >= col)
--     end
--     return after_left and before_right
-- end
--
-- local inside_single_dolar = function()
--     return inside_X_dolar(1)
-- end
--
-- local inside_double_dolar = function()
--     return inside_X_dolar(2)
-- end
--
-- local outside_dolar = function()
--     return not inside_X_dolar(1) and not inside_X_dolar(2)
-- end
-- local m = require("luasnip.extras.conditions").make_condition(inside_single_dolar)
-- local M = require("luasnip.extras.conditions").make_condition(inside_double_dolar)
-- local T = require("luasnip.extras.conditions").make_condition(outside_dolar)

-- Vimtex need to be installed
local in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
local in_text = function()
  return not in_mathzone()
end
local in_comment = function()
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
local in_env = function(name)
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
local in_break_line = function()
    return in_env('align')
end

local M = require("luasnip.extras.conditions").make_condition(in_mathzone)
local T = require("luasnip.extras.conditions").make_condition(in_text)
local BL = require("luasnip.extras.conditions").make_condition(in_break_line)

-- End Conditions }--

as(
    s(
        "preamble", 
        fmta([[ 
            \documentclass[a4paper, 12pt]{article}
            \usepackage[utf8]{inputenc}
            \usepackage[margin=1in]{geometry}
            \usepackage{indentfirst}
            \usepackage{amsthm, amsmath, amsfonts, amssymb, thmtools, mathtools}
            \usepackage{shadethm}
            \usepackage{float}
            \usepackage{graphicx}
            \usepackage{fancyhdr}
            \usepackage{algorithm}
            \usepackage{algorithmic}
            \usepackage{ebproof}
            \usepackage{hyperref}
            \usepackage{etoolbox}
            
            \AtBeginEnvironment{align}{\setcounter{equation}{0}}
            \newcommand{\floor}[1]{\lfloor #1 \rfloor}
            
            \newtheorem{definition}{Definição}[section]
            \newtheorem{theorem}{Teorema}[section]
            \newtheorem{colorario}{Colorário}[section]
            \newtheorem{lemma}[theorem]{Lema}
            
            \hypersetup{
                colorlinks=true,
                linkcolor=cyan,
                filecolor=blue,      
                urlcolor=cyan,
                pdfpagemode=FullScreen,
            }
            
            \pagestyle{fancy}
            \fancyhead[L]{Trabalho X}
            \fancyhead[R]{Paulo Roberto}
            \fancyfoot[C]{\thepage}
            \setlength{\headheight}{{14.5pt}}
    ]], {}
        )
    )
)

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
                <>
            ]], 
            {
                i(1, "math"),
                i(2, ""),
            }
        )
    )
)

-- Comparators
aa(s({trig="!=", condition=M},fmta([[\neq]],{})))
aa(s({trig=">=", condition=M},fmta([[\geq]],{})))
aa(s({trig="<=", condition=M},fmta([[\leq]],{})))

-- Arithmetic
aa(s({trig="([^%s]+)pw",regTrig=true,condition=M},
    fmta([[<>^{<>}]],{f(function(_, snip) return snip.captures[1] end),i(1,""),})))
aa(s({trig="sq", condition=M},fmta([[\sqrt{<>}]],{i(1,"")})))
aa(s({trig="([^%s]+)ss",regTrig=true,condition=M},
    fmta([[<>_{<>}]],{f(function(_, snip) return snip.captures[1] end),i(1,""),})))
aa(s({trig="//", condition=M},fmta([[\frac{<>}{<>}]],{i(1,""),i(2,"")})))
aa(s({trig="([%+%-%*])/", regTrig=true, condition=M},fmta([[<>\frac{<>}{<>}]],
    {f(function(_, snip) return snip.captures[1] end), i(1,""), i(2,"")})))
aa(s({trig="([^%s$(){}]+)/", regTrig=true, condition=M},fmta([[\frac{<>}{<>}]],
    {f(function(_, snip) return snip.captures[1] end), i(1,"")})))
aa(s({trig="(%b())/", regTrig=true, condition=M},fmta([[\frac{<>}{<>}]],
    {f(function(_, snip) return snip.captures[1]:sub(2,-2) end), i(1,"")})))

-- Greek letters
aa(s({trig=";a", condition=M},fmta([[\alpha]],{})))
aa(s({trig=";A", condition=M},fmta([[\alpha]],{})))
aa(s({trig=";b", condition=M},fmta([[\beta]],{})))
aa(s({trig=";B", condition=M},fmta([[\beta]],{})))
aa(s({trig=";c", condition=M},fmta([[\chi]],{})))
aa(s({trig=";c", condition=M},fmta([[\chi]],{})))
aa(s({trig=";d", condition=M},fmta([[\delta]],{})))
aa(s({trig=";D", condition=M},fmta([[\Delta]],{})))
aa(s({trig=";e", condition=M},fmta([[\epsilon]],{})))
aa(s({trig=";E", condition=M},fmta([[\epsilon]],{})))
aa(s({trig=";ve", condition=M},fmta([[\varepsilon]],{})))
aa(s({trig=";vE", condition=M},fmta([[\varepsilon]],{})))
aa(s({trig=";g", condition=M},fmta([[\gamma]],{})))
aa(s({trig=";G", condition=M},fmta([[\Gamma]],{})))
aa(s({trig=";k", condition=M},fmta([[\kappa]],{})))
aa(s({trig=";K", condition=M},fmta([[\kappa]],{})))
aa(s({trig=";l", condition=M},fmta([[\lambda]],{})))
aa(s({trig=";L", condition=M},fmta([[\Lambda]],{})))
aa(s({trig=";m", condition=M},fmta([[\mu]],{})))
aa(s({trig=";M", condition=M},fmta([[\mu]],{})))
aa(s({trig=";o", condition=M},fmta([[\omega]],{})))
aa(s({trig=";O", condition=M},fmta([[\Omega]],{})))
aa(s({trig=";p", condition=M},fmta([[\pi]],{})))
aa(s({trig=";P", condition=M},fmta([[\Pi]],{})))
aa(s({trig=";r", condition=M},fmta([[\rho]],{})))
aa(s({trig=";R", condition=M},fmta([[\rho]],{})))
aa(s({trig=";s", condition=M},fmta([[\sigma]],{})))
aa(s({trig=";S", condition=M},fmta([[\Sigma]],{})))
aa(s({trig=";t", condition=M},fmta([[\theta]],{})))
aa(s({trig=";T", condition=M},fmta([[\Theta]],{})))
aa(s({trig=";u", condition=M},fmta([[\upsilon]],{})))
aa(s({trig=";U", condition=M},fmta([[\Upsilon]],{})))
aa(s({trig=";z", condition=M},fmta([[\zeta]],{})))
aa(s({trig=";Z", condition=M},fmta([[\Zeta]],{})))

-- Set
aa(s({trig="bb", condition=M},fmta([[\mathbb{<>}]],{i(1,"")})))
aa(s({trig="dots", condition=M},fmta([[\dots]],{})))
aa(s({trig="eset", condition=M},fmta([[\emptyset]],{})))
aa(s({trig="in", condition=M},fmta([[\in]],{})))
aa(s({trig="notin", condition=M},fmta([[\not \in]],{})))
aa(s({trig="sand", condition=M},fmta([[\cap]],{})))
aa(s({trig="set", condition=M},fmta([[\{<>\}]],{i(1,"")})))
aa(s({trig="sor", condition=M},fmta([[\cup]],{})))

-- Symbols
aa(s({trig="ooo", condition=M},fmta([[\infty]],{})))
aa(s({trig="lim", condition=M},fmta([[\lim_{<> \to <>}]],{i(1,"x"),i(2,"\\infty")})))
aa(s({trig="prod", condition=M},fmta([[\prod_{<>}^{<>}]],{i(1,""),i(2,"")})))
aa(s({trig="sum", condition=M},fmta([[\sum_{<>}^{<>}]],{i(1,""),i(2,"")})))

-- Arrows
aa(s({trig="<a", condition=M},fmta([[\leftarrow]],{})))
aa(s({trig="<A", condition=M},fmta([[\Leftarrow]],{})))
aa(s({trig=">a", condition=M},fmta([[\rightarrow]],{})))
aa(s({trig=">A", condition=M},fmta([[\Rightarrow]],{})))
aa(s({trig="<>a", condition=M},fmta([[\leftrightarrow]],{})))
aa(s({trig="<>A", condition=M},fmta([[\Leftrightarrow]],{})))

-- Math Fonts
aa(s({trig="(%a)%.cal", regTrig=true, condition=M}, {f(function(_, snip) return "\\mathcal{" .. snip.captures[1] .."}" end)}))

-- Enviroment
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

as(
    s("begin",
        fmta(
            [[
                \begin{<>}
                    <>
                \end{<>}
                <>
            ]],
            {
                i(1, ""),
                i(2, ""),
                rep(1),
                i(0, ""),
            }
        )
    )
)

-- TODO:
aa(s({trig="%c", regTrig=true, condition=BL}, fmta(
    [[
        \\
        
    ]], 
{})))

-- Complex Snippets(but cooler)
table_node= function(args)
	local tabs = {}
	local count
	table = args[1][1]:gsub("%s",""):gsub("|","")
	count = table:len()
	for j=1, count do
		local iNode
		iNode = i(j)
		tabs[2*j-1] = iNode
		if j~=count then
			tabs[2*j] = t" & "
		end
	end
	return sn(nil, tabs)
end
rec_table = function ()
	return sn(nil, {
		c(1, {
			t({""}),
			sn(nil, {t{"\\\\",""} ,d(1,table_node, {ai[1]}), d(2, rec_table, {ai[1]})})
		}),
	});
end
as(s("table", {
	t"\\begin{tabular}{",
	i(1,"0"),
	t{"}",""},
	d(2, table_node, {1}, {}),
	d(3, rec_table, {1}),
	t{"","\\end{tabular}"}
}))

-- Visual Snippets
as(s({trig="uepa"}, fmta(
    [[
        "<>"
    ]], 
{d(1, get_visual)})))


return snippets, autosnippets
