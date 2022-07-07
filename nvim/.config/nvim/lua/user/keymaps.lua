local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Insert --
--keymap("i", "jk", "<ESC>", opts)                -- Enter in Normal Mode Faster
--keymap("i", "kj", "<ESC>", opts)                -- Enter in Normal Mode Faster

-- Normal --
keymap("n", "<leader><C-V>", "\"+p", opts)      -- Copy For Machine Clipboard

-- Visual --
keymap("v", "<C-C>", "\"+y", opts)              -- Paste Machine Clipboard
