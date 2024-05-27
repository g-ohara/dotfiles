-- indent.lua
-- This file configures the indentation settings for various file types


-- Set indentation to 2 spaces by default
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Insert indents automatically when starting a new line
vim.opt.smartindent = true

-- Only use spaces for indentation (no tabs)
vim.opt.expandtab = true

-- Set indentation to 4 spaces for specific file types
vim.api.nvim_create_autocmd(
  "FileType",
  {
    group = vim.api.nvim_create_augroup("local_indent", {}),
    pattern = { "python" },
    callback = function()
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
    end
  }
)
