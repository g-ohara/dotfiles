return {
  cmd = { "uv", "run", "pyright-langserver", "--stdio" },
  before_init = function(params)
    params.processId = vim.NIL
  end,
}
