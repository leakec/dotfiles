-- LSP
return {
    {
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
            vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', {silent=true})
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
        end
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'hrsh7th/cmp-path'},     -- Optional, for path autocomplete
            {'hrsh7th/cmp-nvim-lsp-signature-help'}, -- Optional, used for completion inside function signatures
            {'saadparwaiz1/cmp_luasnip'}, -- Completion for lua snippets
            {'L3MON4D3/LuaSnip'}, -- Lua snippets
        },
        event="VeryLazy",
        config = function()
            -- You need to setup `cmp` after lsp-zero
            local cmp = require('cmp')

            cmp.setup({
                -- Menu is hidden by default, invoked only when I call it
                completion = {
                    autocomplete = false,
                },

                -- Completion sources
                sources = {
                    {name = 'nvim_lsp'},
                    {name = 'nvim_lsp_signature_help'},
                    {name = 'path'},
                    {name = 'luasnip'},
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },

                -- Key bindings
                mapping = cmp.mapping.preset.insert({
                    -- `Enter` key to confirm completion
                    ['<CR>'] = cmp.mapping.confirm({select = false}),

                    -- Ctrl+K to trigger completion menu
                    ['<C-K>'] = cmp.mapping.complete(),

                    -- Select previous and next item
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<Tab>'] = cmp.mapping.select_next_item(),

                    -- Navigate between snippet placeholder
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                })
            })
        end
    }
}
