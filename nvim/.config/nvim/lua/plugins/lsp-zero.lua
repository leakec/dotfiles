-- LSP
return {
    -- Mason for setting up and installing LSPs
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'mason-org/mason.nvim'},
    },
    config = function()
        -- Adding the same capabilities to all server configs
        vim.lsp.config("*", {
            capabilities = vim.lsp.protocol.make_client_capabilities()
        })

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {'pyright', 'clangd', 'ts_ls', 'rust_analyzer'},
        })

        vim.opt.signcolumn = 'yes'

        vim.api.nvim_set_keymap('n', 'gv', ':vsplit | lua vim.lsp.buf.definition()<CR>', {silent=true})
        vim.api.nvim_set_keymap('n', 'gl', ':lua vim.diagnostic.open_float()<CR>', {silent=true})
        vim.diagnostic.config {
            signs = true,
            underline = true,
            virtual_text = true,
            virtual_lines = false,
            update_in_insert = true,
            float = {
                -- UI.
                header = false,
                border = 'rounded',
                focusable = true,
            }
        }
        vim.keymap.set('i', '<c-K>', function() vim.lsp.buf.signature_help() end, {silent=true})
    end
}
