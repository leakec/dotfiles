-- Tree sitter for code folding
return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = "main",
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter').install { 'python', 'cpp' }
        end
    },

    {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            local tc = require("treesitter-context")
            tc.setup({enable=false})
            vim.keymap.set("n", "<leader>gc", function() tc.go_to_context(vim.v.count1) end, { silent = true })
            vim.keymap.set("n", "<leader>tc", function() vim.cmd("TSContext toggle") end, { silent = true })
        end
    }
}
