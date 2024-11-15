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

-- local M = require("luasnip.extras.conditions").make_condition(in_mathzone)

-- End Conditions }--

return snippets, autosnippets
