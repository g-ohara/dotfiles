return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = '',
      section_separators = '',
    },
    sections = {
      lualine_b = {
        {
          'branch',
          icon = '',
        },
        {
          'diff',
        },
        {
          'diagnostics',
          symbols = { error = 'E:', warn = 'W:', info = 'I:', hint = 'H:' },
        },
      },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding' },
    },
  },
}
