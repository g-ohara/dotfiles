require("lspconfig").bashls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
}
