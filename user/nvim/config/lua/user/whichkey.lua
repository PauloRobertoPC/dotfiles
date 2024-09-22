local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end



which_key.add({

    { "<leader>c", group = "colors" },
    { "<leader>cc", "<cmd>CccConvert<cr>", desc = "[c]onvert", mode = "n" },
    { "<leader>cp", "<cmd>CccPick<cr>", desc = "[p]ick color", mode = "n" },
    { "<leader>cs", "<cmd>CccHighlighterToggle<cr>", desc = "[s]how [c]olors", mode = "n" },

    { "<leader>d", group = "debug" },
    { "<leader>da", "<cmd>lua require'dap'.continue()<CR>", desc = "Continue", mode = "n"  },
    { "<leader>db", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step Over", mode = "n"  },
    { "<leader>dc", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step Into", mode = "n"  },
    { "<leader>dd", "<cmd>lua require'dap'.step_out()<CR>", desc = "Step Out", mode = "n"  },
    { "<leader>de", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle Breakpoint", mode = "n"  },
    { "<leader>df", "<cmd>lua require('dapui').toggle()<CR>", desc = "Toggle DAP UI", mode = "n"  },

    { "<leader>f", group = "find" },
    { "<leader>fb", "<cmd>Telescope git_branches<cr>", desc = "[b]ranch", mode = "n" },
    { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "[c]olorscheme", mode = "n" },
    { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "[C]ommands", mode = "n" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "[f]iles", mode = "n" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "[h]elp", mode = "n" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "[k]eymaps", mode = "n" },
    { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "[M]an pages", mode = "n" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "open [r]ecent File", mode = "n" },
    { "<leader>fR", "<cmd>Telescope registers<cr>", desc = "[R]egisters", mode = "n" },
    { "<leader>ft", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "[t]ext", mode = "n" },

    { "<leader>g", group = "git" },
    { "<leader>gb", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "previous(b) junk", mode = "n" },
    { "<leader>gB", "<cmd>Telescope git_branches<cr>", desc = "checkout [B]ranch", mode = "n" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "checkout [c]ommit", mode = "n" },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "[d]iff", mode = "n" },
    { "<leader>gf", "<cmd>Telescope git_status<cr>", desc = "open changed [f]ile", mode = "n" },
    { "<leader>gw", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "next(w) junk", mode = "n" },
    { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "b[l]ame", mode = "n" },
    { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "[p]review hunk", mode = "n" },
    { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "[r]eset hunk", mode = "n" },
    { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "[R]eset buffer", mode = "n" },
    { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "[s]tage hunk", mode = "n" },
    { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "[u]ndo stage hunk", mode = "n" },

    { "<leader>l", group = "lsp" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "code [A]ction", mode = "n" },
    { "<leader>lb", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Previous(b) Diagnostic", mode = "n" },
    { "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "go to [d]efinition", mode = "n" },
    { "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "go to [D]eclaration", mode = "n" },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", desc = "[f]ormat", mode = "n" },
    { "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "[h]over documentation", mode = "n" },
    { "<leader>lH", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "[H]over signature documentation", mode = "n" },
    { "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "go to [i]mplementation", mode = "n" },
    { "<leader>ll", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "diagnostics [l]ist", mode = "n" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "go to [r]eferences", mode = "n" },
    { "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "[R]ename", mode = "n" },
    { "<leader>ls", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "[s]how diagnostic", mode = "n" },
    { "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "go to [t]ype definition", mode = "n" },
    { "<leader>lw", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "next(w) diagnostic", mode = "n" },

    { "<leader>o", group = "open" },
    { "<leader>ob", "<cmd>ObsidianOpen<cr>", desc = "o[b]sidian", mode = "n" },
    { "<leader>od", "<cmd>Telescope diagnostics<cr>", desc = "[d]iagnostics", mode = "n" },
    { "<leader>oe", function() if not MiniFiles.close() then MiniFiles.open() end end, desc = "[e]xplorer tree", mode = "n"  },
    { "<leader>ol", "<cmd>VimtexCompile<cr>", desc = "[l]atex", mode = "n"  },
    { "<leader>om", "<cmd>MarkdownPreviewToggle<cr>", desc = "[m]arkdown", mode = "n"  },
    { "<leader>oo", "<cmd>SymbolsOutline<cr>", desc = "[o]utline", mode = "n"  },
    { "<leader>op", "<cmd>TSPlaygroundToggle<cr>", desc = "treesitter [p]layground", mode = "n"  },
    { "<leader>ot", "<cmd>TodoTelescope<cr>", desc = "[t]odo telescope", mode = "n" },

    { "<leader>h", "<cmd>nohlsearch<CR>", desc = "No [h]ighlight", mode = "n" },
    { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Comment", mode = "n" },

    { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Comment", mode = "v" },
})
