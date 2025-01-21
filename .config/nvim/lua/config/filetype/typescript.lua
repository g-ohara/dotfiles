-- Javascript/Typescript

require('lspconfig').ts_ls.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
}
