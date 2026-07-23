return {
  cmd = {
    'clangd',
    '--fallback-style=none', -- Disable formatter unless there is `.clang-format`
  },
  filetypes = { 'c', 'cpp' },
}
