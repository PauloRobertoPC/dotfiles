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



local template = s("template", 
    fmt([[ 
        
        \documentclass[a4paper, 12pt]{{article}}
        \usepackage[utf8]{{inputenc}}
        \usepackage[margin=1in]{{geometry}}
        \usepackage{{indentfirst}}
        \usepackage{{amsthm, amsmath, amsfonts, amssymb, thmtools, mathtools}}
        \usepackage{{shadethm}}
        \usepackage{{float}}
        \usepackage{{graphicx}}
        \usepackage{{fancyhdr}}
        \usepackage{{algorithm}}
        \usepackage{{algorithmic}}
        \usepackage{{ebproof}}
        \usepackage{{hyperref}}
        \usepackage{{etoolbox}}
        
        \AtBeginEnvironment{{align}}{{\setcounter{{equation}}{{0}}}}
        \newcommand{{\floor}}[1]{{\lfloor #1 \rfloor}}
        
        \newtheorem{{definition}}{{Definição}}[section]
        \newtheorem{{theorem}}{{Teorema}}[section]
        \newtheorem{{colorario}}{{Colorário}}[section]
        \newtheorem{{lemma}}[theorem]{{Lema}}
        
        \hypersetup{{
            colorlinks=true,
            linkcolor=cyan,
            filecolor=blue,      
            urlcolor=cyan,
            pdfpagemode=FullScreen,
        }}
        
        \pagestyle{{fancy}}
        \fancyhead[L]{{Trabalho X}}
        \fancyhead[R]{{Paulo Roberto}}
        \fancyfoot[C]{{\thepage}}
        \setlength{{\headheight}}{{14.5pt}}
        
        \begin{{document}}	
        \end{{document}}
]], {}
    )
)
table.insert(snippets, template)

local photo = s("photo", 
    fmt([[ 
	    \begin{{figure}}[H]
	    	\caption{{}}
	    	\centering			
	    	\includegraphics[scale=0.5]{{Fotos/SGBD1.png}}
	    \end{{figure}}	
]], {}
    )
)
table.insert(snippets, photo)

local matrix = s("matrix", 
    fmt([[ 
	    $
	    \begin{{bmatrix}}
	    	1 & 0 \\
	    	0 & 1
	    \end{{bmatrix}}
	    $
]], {}
    )
)
table.insert(snippets, matrix)

local systemeq = s("systemeq", 
    fmt([[ 
	    $\left\{{
	    \begin{{array}}{{cl}}
	    	x + y & = 0 \\
	    	x + 2y & = 0
	    \end{{array}}
	    \right.$
]], {}
    )
)
table.insert(snippets, systemeq)

local tableltx = s("table", 
    fmt([[ 
	    \begin{{table}}[H]
	    	\centering
	    	\caption{{}}
	    	\begin{{tabular}}{{|c|c|c|c|}}
	    		\hline
	    		------ & Coluna 1 & Coluna 2 & Coluna 3 \\ \hline
	    		Linha 1 & 1 & 2 & 3 \\ \hline
	    		Linha 2 & 4 & 5 & 6 \\ \hline
	    		Linha 3 & 7 & 8 & 9 \\ \hline
	    	\end{{tabular}}
	    \end{{table}}
]], {}
    )
)
table.insert(snippets, tableltx)

local enumerate = s("enumerate", 
    fmt([[ 
        \begin{{enumerate}}
            \item
        \end{{enumerate}}
]], {}
    )
)
table.insert(snippets, enumerate)

local itemize = s("itemize", 
    fmt([[ 
        \begin{{itemize}}
            \item
        \end{{itemize}}
]], {}
    )
)
table.insert(snippets, itemize)


local link = s("link", 
    fmt([[ 
        \href{{}}{{}}
]], {}
    )
)
table.insert(snippets, link)

local teorema = s("teorema", 
    fmt([[ 
        \begin{{theorem}}
        
        \end{{theorem}}
]], {}
    )
)
table.insert(snippets, teorema)

local definicao = s("definicao", 
    fmt([[ 
        \begin{{definition}}
        
        \end{{definition}}
]], {}
    )
)
table.insert(snippets, definicao)

local prova = s("prova", 
    fmt([[ 
        \begin{{proof}}
        
        \end{{proof}}
]], {}
    )
)
table.insert(snippets, prova)


local mod = s("mod", 
    fmt([[ 
       {} \equiv {} \pmod{{{}}}{}
]], 
        {
            i(1, "A"),
            i(2, "B"),
            i(3, "MOD"),
            i(4, ""),
        }
    )
)
table.insert(snippets, mod)


local legendre = s("legendre", 
    fmt([[ 
        \left(\dfrac{{{}}}{{{}}}\right)
]], 
        {
            i(1, "A"),
            i(2, "B"),
        }
    )
)
table.insert(snippets, legendre)

-- End Refactoring --

return snippets, autosnippets
