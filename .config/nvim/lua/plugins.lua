------------------------------------------------------------------------------
-- Plugins
------------------------------------------------------------------------------

-- Install lazy.nvim (https://github.com/folke/lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system(
    {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    }
  )
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup(
  {
    'nvim-lualine/lualine.nvim',
    'Exafunction/codeium.vim',
    'neovim/nvim-lspconfig',
    'lewis6991/gitsigns.nvim',
  }
)


------------------------------------------------------------------------------
-- nvim-lualine/lualine.nvim
------------------------------------------------------------------------------

require('lualine').setup {
  options = {
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_b = {
      {
        'branch',
        icon = '',
      },
      {
        'diff',
      },
      {
        'diagnostics',
        symbols = { error = 'E:', warn = 'W:', info = 'I:', hint = 'H:' },
      },
    },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding' },
  },
}


------------------------------------------------------------------------------
-- lewis6991/gitsigns.nvim
------------------------------------------------------------------------------

require('gitsigns').setup()
