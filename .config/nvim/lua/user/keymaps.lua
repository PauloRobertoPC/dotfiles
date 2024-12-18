local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
keymap("n", "<leader><C-V>", "\"+p", opts)      -- Copy For Machine Clipboard

-- Visual --
keymap("v", "<C-C>", "\"+y", opts)              -- Paste Machine Clipboard
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)      -- Code up
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)      -- Code down
