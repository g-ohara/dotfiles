-- general.lua
-- This file configures general settings for Neovim


-- Disable providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Save undo history
vim.opt.undofile = true

-- Automatically format on save
vim.api.nvim_create_autocmd(
  "BufWritePre",
  {
    group = vim.api.nvim_create_augroup("lsp_format", {}),
    callback = function()
      vim.lsp.buf.format()
    end,
  }
)

-- Visually indent wrapped lines
vim.opt.breakindent = true

-- Set column lign at 80 characters by default
vim.opt.colorcolumn = "80"

-- Display underline for cursor line
vim.opt.cursorline = true

-- Set line number
vim.opt.number = true

-- Not show mode since it is already shown by lualine
vim.opt.showmode = false

-- Enable syntax highlighting
vim.opt.syntax = "on"

-- Set indentation to 2 spaces by default
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Insert indents automatically when starting a new line
vim.opt.smartindent = true

-- Only use spaces for indentation (no tabs)
vim.opt.expandtab = true

-- Automatically pop up diagnostics window
vim.api.nvim_set_option('updatetime', 500)
vim.api.nvim_create_autocmd(
  "CursorHold",
  {
    group = vim.api.nvim_create_augroup("diagnostic", {}),
    callback = function()
      vim.diagnostic.open_float()
    end,
  }
)
