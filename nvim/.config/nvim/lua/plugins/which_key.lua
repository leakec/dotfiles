return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- Turn off the automatic popup
    triggers = {},
  },
  vim.keymap.set("n", "<leader>?", ":WhichKey<CR>", { noremap = true, silent = true }) -- Manual trigger
}
