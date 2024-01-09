local servers = {
    'lua_ls',
    'jdtls',
    'pyright',
    'emmet_ls',
    'cssls',
    'rnix',
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

-- clangd settings
local home = os.getenv("HOME")
require('lspconfig')['clangd'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { home .. '/.nix-profile/bin/clangd' },
    flags = {
        -- This will be the default in neovim 0.7+
        debounce_text_changes = 150,
    }
}
