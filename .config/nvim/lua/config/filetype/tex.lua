-- Open the target PDF on save
vim.api.nvim_create_autocmd(
  "BufWritePost",
  {
    pattern = { "*.tex", '*.lhs' },
    group = vim.api.nvim_create_augroup("AutoFormat", {}),
    callback = function()
      vim.cmd("silent !evince %:r.pdf & ")
    end,
  }
)
