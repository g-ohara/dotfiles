-- TeX, Literate Haskell, Plain TeX, BibTeX

local lspconfig = require('lspconfig')

lspconfig.texlab.setup {
  filetypes = { 'tex', 'lhaskell', 'plaintex', 'bib' },
  root_dir = lspconfig.util.root_pattern(
    'latexmkrc',
    '.git',
    '.latexmkrc',
    '.texlabroot',
    'texlabroot',
    'Tectonic.toml'
  ),
  settings = {
    texlab = {
      build = {
        args = {},
        onSave = true,
      },
      chktex = {
        onEdit = true,
        onOpenAndSave = true,
      },
      latexindent = {
        args = { '-l' },
      },
    },
  },
}

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
