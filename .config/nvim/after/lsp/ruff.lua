return {
  cmd = { "uv", "run", "ruff", "server" },
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
