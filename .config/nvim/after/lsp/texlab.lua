return {
  filetypes = { 'tex', 'lhaskell', 'plaintex', 'bib' },
  root_markers = {
    'latexmkrc',
    '.git',
    '.latexmkrc',
    '.texlabroot',
    'texlabroot',
    'Tectonic.toml'
  },
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
