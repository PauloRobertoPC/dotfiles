local servers = {
    'clangd',
    'cssls',
    'emmet_ls',
    'eslint',
    -- 'html',
    'jdtls',
    -- 'tsserver',
    'pyright',
}
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = servers,
    automatic_installation = true,
}
require("symbols-outline").setup()

local options = function(desc)
    local opts = { noremap=true, silent=true, desc = desc }
    return opts
end


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

    -- My configurations
    require "lsp_signature".on_attach()
    -- print("LSP has started")

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', options("Code [a]ction"))
    --
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', options("Go to [D]eclaration"))
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', options("Go to [d]efinition"))
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', options("Go to [i]mplementation"))
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', options("Go to [t]ype Definition"))
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lr', '<cmd>lua vim.lsp.buf.references()<CR>', options("Go to [r]eferences"))
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lR', '<cmd>lua vim.lsp.buf.rename()<CR>', options("[R]ename"))
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', options("[h]over Documentation"))
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lH', '<cmd>lua vim.lsp.buf.signature_help()<CR>', options("[H]over Signature Documentation"))
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', options("[f]ormat"))

    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', options("TESTE"))
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', options("TESTE"))
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', options("TESTE"))
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }
end

-- dartls settings
require('lspconfig')['dartls'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        -- This will be the default in neovim 0.7+
        debounce_text_changes = 150,
    }
}

-- example in how the serrver is attached

-- require'lspconfig'.clangd.setup{
--     on_attach = function()
--         print("Just an example to run in a specific server")
--     end,
-- }
