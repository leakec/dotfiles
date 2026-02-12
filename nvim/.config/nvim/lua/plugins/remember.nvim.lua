return {
    -- Store last position when closing a file
    'vladdoster/remember.nvim',

    config = function()
        require("remember").setup({})
    end
}
