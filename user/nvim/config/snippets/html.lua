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
        <!DOCTYPE html>
        <html lang="pt-br">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" contet="width=device-width, initial-scale=1.0">
                <title>{}</title> 
            </head>
            <body>
                {}
            </body>
        </html>
]], 
        {
            i(1, "Title"),
            i(2, ""),
        }
    )
)

local h1 = s("h1", 
    fmt([[<h1>{}</h1>]], { i(1, ""),})
)
local h2 = s("h2", 
    fmt([[<h2>{}</h2>]], { i(1, ""),})
)
local h3 = s("h3", 
    fmt([[<h3>{}</h3>]], { i(1, ""),})
)
local h4 = s("h4", 
    fmt([[<h4>{}</h4>]], { i(1, ""),})
)
local h5 = s("h5", 
    fmt([[<h5>{}</h5>]], { i(1, ""),})
)
local h6 = s("h6", 
    fmt([[<h6>{}</h6>]], { i(1, ""),})
)
local p = s("p", 
    fmt([[<p>{}</p>]], { i(1, ""),})
)

local br = s("br", 
    fmt([[<br>]], {})
)

local hr = s("hr", 
    fmt([[
    <hr>
    {}
    ]], { i(1, ""),})
)

local a = s("a", 
    fmt([[
    <a href="{}" {}>{}</a>
    ]], { i(1, "#"), c(2, {t("target=\"self\""), t("target=\"_blank\" rel=\"external\""), }), i(3, "Text"),})
)

local img = s("img", 
    fmt([[<img src="{}" alt="{}">]], {i(1, "path"), i(2, "desc"),})
)


local favicon = s("favicon", 
    fmt([[<link rel="shortcut icon" href="{}" type="image/x-icon">
]], {i(1, "path"),})
)

local css = s("css", 
    fmt([[<link rel="stylesheet" href="{}">
]], {i(1, "path"),})
)

local strong = s("strong", 
    fmt([[<strong> {} </strong>
]], {i(1, "texto"),})
)

local em = s("em", 
    fmt([[<em> {} </em>
]], {i(1, "texto"),})
)

local mark = s("mark", 
    fmt([[<mark> {} </mark>
]], {i(1, "texto"),})
)

local small = s("small", 
    fmt([[<small> {} </small>
]], {i(1, "texto"),})
)

local del = s("del", 
    fmt([[<del> {} </del>
]], {i(1, "texto"),})
)

local ins = s("ins", 
    fmt([[<ins> {} </ins>
]], {i(1, "texto"),})
)

local sub = s("sub", 
    fmt([[<sub> {} </sub>
]], {i(1, "texto"),})
)

local sup = s("sup", 
    fmt([[<sup> {} </sup>
]], {i(1, "texto"),})
)

local li = s("li", 
    fmt([[<li> {} </li>
]], {i(1, "item"),})
)

local ol = s("ol", 
    fmt([[ 
        <ol type="{}">
            <li> {} </li>
        </ol>
]], 
        {
            c(1, { t("1"), t("a"), t("A"), t("i"), t("I")}),
            i(2, ""),
        }
    )
)

local ul = s("ul", 
    fmt([[ 
        <ul type="{}">
            <li> {} </li>
        </ul>
]], 
        {
            c(1, { t("disc"), t("circle"), t("square")}),
            i(2, ""),
        }
    )
)

local dt = s("dt", 
    fmt([[<dt> {} </dt>
]], {i(1, "termo"),})
)

local dd = s("dd", 
    fmt([[<dd> {} </dt>
]], {i(1, "descrição"),})
)

local dl = s("dl", 
    fmt([[ 
        <dl>
            <dt> {} </dt>
            <dd> {} </dd>
        </dl>
]], 
        {
            i(1, "termo"),
            i(2, "descrição"),
        }
    )
)


local source_media = s("source-media", 
    fmt([[<source media="(max-width: {}x)" srcset="{}">
]], {i(1, "width"), i(2, "path"), })
)

local picture = s("picture", 
    fmt([[ 
        <picture>
            <source media="(max-width: {}px)" srcset="{}">
            <img src="{}">
        </picture>
]], 
        {
            i(1, "width"),
            i(2, "path"),
            i(3, "path"),
        }
    )
)

local audio = s("audio", 
    fmt([[ 
        <audio controls>
            <source src="{}" type="{}">
            Your browser does not support the audio element.
        </audio> 
]], 
        {
            i(1, "path"),
            c(2, {t("audio/mpeg"), t("")}),
        }
    )
)

local video = s("video", 
    fmt([[ 
        <video controls>
            <source src="{}" type="{}">
            Your browser does not support the video element.
        </video> 
]], 
        {
            i(1, "path"),
            c(2, {t("video/mp4"), t("")}),
        }
    )
)

local style = s("style", 
    fmt([[
    <style>
        {} 
    </style>
]], {i(1, ""),})
)

local script = s("script", 
    fmt([[
    <script>
        {} 
    </script>
]], {i(1, ""),})
)

local div = s("div", 
    fmt([[
    <div>
        {} 
    </div>
]], {i(1, ""),})
)


local abbr = s("abbr", 
    fmt([[<abbr title="{}">{}</abbr>
]], {i(1, "desc"), i(2, "content"),})
)

table.insert(snippets, template)
table.insert(snippets, h1)
table.insert(snippets, h2)
table.insert(snippets, h3) 
table.insert(snippets, h4) 
table.insert(snippets, h5) 
table.insert(snippets, h6) 
table.insert(snippets, p) 
table.insert(snippets, br)
table.insert(snippets, hr)
table.insert(snippets, a)
table.insert(snippets, img)
table.insert(snippets, favicon)
table.insert(snippets, css)
table.insert(snippets, strong)
table.insert(snippets, em)
table.insert(snippets, mark)
table.insert(snippets, small)
table.insert(snippets, del)
table.insert(snippets, ins)
table.insert(snippets, sup)
table.insert(snippets, sub)
table.insert(snippets, li)
table.insert(snippets, ol)
table.insert(snippets, ul)
table.insert(snippets, dt)
table.insert(snippets, dd)
table.insert(snippets, dl)
table.insert(snippets, source_media)
table.insert(snippets, picture)
table.insert(snippets, audio)
table.insert(snippets, video)
table.insert(snippets, script)
table.insert(snippets, style)
table.insert(snippets, div)
table.insert(snippets, abbr)

-- End Refactoring --

return snippets, autosnippets
