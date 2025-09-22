vim.api.nvim_create_autocmd(
  "BufWritePost",
  {
    pattern = { "*.py", "*.pyi" },
    group = vim.api.nvim_create_augroup("AutoFormat", {}),
    callback = function()
      vim.cmd("silent !rye fmt %")
      vim.cmd("silent !rye lint --fix %")
      vim.cmd("edit")
    end,
  }
)

-- Set column lign at 72 and 79 characters and indentation to 4 spaces
vim.api.nvim_create_autocmd(
  "FileType",
  {
    group = vim.api.nvim_create_augroup("python", {}),
    pattern = { "python" },
    callback = function()
      vim.opt.colorcolumn = "72,79"
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
    end
  }
)
