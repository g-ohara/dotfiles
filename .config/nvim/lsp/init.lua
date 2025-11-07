vim.lsp.enable('bashls')
vim.lsp.enable('clangd')
vim.lsp.enable('hls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')
vim.lsp.enable('ruff')
vim.lsp.enable('texlab')
vim.lsp.enable('ts_ls')

-- LSP keybindings
vim.api.nvim_create_autocmd(
  "LspAttach",
  {
    callback = function(event)
      local opts = {
        noremap = true,
        silent = true,
        buffer = event.buf,
      }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    end,
  }
)
