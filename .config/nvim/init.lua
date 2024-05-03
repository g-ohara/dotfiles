------------------------------------------------------------------------------
-- Formatting
------------------------------------------------------------------------------

-- Set indentation to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Insert indents automatically when starting a new line
vim.opt.smartindent = true

-- Only use spaces for indentation (no tabs)
vim.opt.expandtab = true

-- Set indentation to 2 spaces for C and C++
vim.api.nvim_create_augroup('local_indent', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'local_indent',
  pattern = { 'c', 'cpp', 'lua', 'vim' },
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
  end
})

-- Format automatically on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('lsp_format', { clear = true }),
  callback = function()
    vim.lsp.buf.format()
  end
})


------------------------------------------------------------------------------
-- Design of the editor
------------------------------------------------------------------------------

-- Set line number
vim.opt.number = true

-- Display underline for cursor line
vim.opt.cursorline = true

-- Set column lign at 80 characters
vim.opt.colorcolumn = '80'
vim.cmd("highlight ColorColumn ctermbg=DarkGrey guibg=lightgrey")

-- Always show the status line
vim.opt.laststatus = 2

-- Set color of vim terminal
-- My favorite themes are 'desert', 'evening', 'habamax' and 'slate'
vim.cmd [[colorscheme desert]]

-- Enable syntax highlighting
vim.opt.syntax = 'on'


------------------------------------------------------------------------------
-- Plugins
------------------------------------------------------------------------------

require('plugins')
