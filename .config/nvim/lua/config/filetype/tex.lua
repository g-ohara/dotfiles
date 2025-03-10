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
