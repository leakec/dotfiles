-- Set the leader key 
vim.g.mapleader = ' '

-- Set termguicolors to true
vim.opt.termguicolors = true

-- Lazy.nvim plugin loading
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins")

-- Set tab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Set persistent undo
vim.opt.undodir = os.getenv("HOME") .. "/.vimdid"
vim.opt.undofile = true

-- Turn line numbering on, used in conjunction with sitiom/nvim-numbertoggle plugin
vim.opt.number = true

-- Split new windows to the right or below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Bash-like tab completion
vim.o.wildmode = "longest,list,full"

---Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('yank_highlight', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup='IncSearch', timeout=300 }
  end,
})

-- Copy text using OSC 52, but keep the normal paste options
if (os.getenv('SSH_TTY') == nil)
then
    vim.opt.clipboard:append("unnamedplus")
else
    local osc52 = require("vim.ui.clipboard.osc52")
    local function my_paste(_)
        return function(_)
            local content = vim.fn.getreg('"')
            return vim.split(content, '\n')
        end
    end

    local function my_copy(reg)
        local orig = osc52.copy(reg)
        return function(lines, regtype)
            -- Write to Vim's internal register
            vim.fn.setreg('"', table.concat(lines, "\n"), regtype)

            -- Send OSC52 to local clipboard
            orig(lines, regtype)
        end
    end

    vim.g.clipboard = {
      name = 'OSC 52',
      copy = {
        ['+'] = my_copy('+'),
        ['*'] = my_copy('*'),
      },
      paste = {
        ["+"] = my_paste("+"),
        ["*"] = my_paste("*"),
        }
    }
    vim.opt.clipboard = "unnamedplus"
end

-- Used to check if package is available 
function isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

-- USER FUNCTIONS
if isModuleAvailable("user.functions") then
    require('user.functions')
end
