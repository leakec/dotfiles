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

        vim.keymap.set("n", "<Leader>ncf", function()
            -- Run yamroot and trim newline
            local root = vim.fn.system("yamroot"):gsub("%s+$", "")
            local config_path = root ~= "" and (root .. "/common/ruff.toml") or nil
            local cmd

            if config_path and vim.fn.filereadable(config_path) == 1 then
                cmd = "ruff check "
                .. " --config "
                .. vim.fn.shellescape(config_path)
                .. " --output-format=concise"
            else
                cmd = "ruff check "
                .. " --select D --output-format=concise"
            end

            -- Use :cexpr so quickfix opens automatically
            vim.cmd("cexpr system(\"" .. cmd .. "\")")
        end, { desc = "Ruff docstring check (quickfix)" })

    end
}
