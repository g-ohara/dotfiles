return {
  cmd = { "uv", "run", "ruff", "server" },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  settings = {},
  on_attach = function(_, buffer)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = buffer,
      callback = function()
        vim.lsp.buf.code_action(
          {
            context = {
              only = {
                "source.fixAll.ruff",
              },
            },
            apply = true,
          }
        )
      end,
    })
  end,
}
