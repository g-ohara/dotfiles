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
    pattern = "*",
    callback = function()
      vim.lsp.buf.format()
    end
  }
)
