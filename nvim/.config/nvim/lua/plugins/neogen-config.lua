-- Docstrings
return {
    "danymat/neogen", 
    event="VeryLazy",
    dependencies = "nvim-treesitter/nvim-treesitter", 
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*" 
    config = function()
        require('neogen').setup {
            enabled = true,
            languages = {
                python = {
                    template = {
                        annotation_convention = "numpydoc"
                    }
                },
                ['cpp.doxygen'] = require('neogen.configurations.cpp')
            }
        }

        vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<Leader>ncf", ":cexpr system(\"python -m pydocstyle | paste - - | sed -n 's|^\\\\(.*\\\\):\\\\([0-9]\\\\+\\\\).* \\\\(D[0-9]\\\\+.*\\\\)|\\\\1:\\\\2:0:\\\\3|p'\")<CR>", { noremap = true, silent = true })
    end
}
