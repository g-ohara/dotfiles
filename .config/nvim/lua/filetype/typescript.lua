-- Javascript/Typescript

require('lspconfig').tsserver.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
}
