------------------------------------------------------------------------------
-- Plugins
------------------------------------------------------------------------------

-- Install lazy.nvim (https://github.com/folke/lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system(
    {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    }
  )
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup(
  {
    'nvim-lualine/lualine.nvim',
    'Exafunction/codeium.vim',
    'neovim/nvim-lspconfig',
  }
)


------------------------------------------------------------------------------
-- nvim-lualine/lualine.nvim
------------------------------------------------------------------------------

require('lualine').setup {
  options = {
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_b = { 'filename' },
    lualine_c = {},
    lualine_x = { 'encoding' },
  },
}

------------------------------------------------------------------------------
-- neovim/nvim-lspconfig
------------------------------------------------------------------------------

local lspconfig = require("lspconfig")

-- C/C++
lspconfig.clangd.setup {}

-- Haskell
lspconfig.hls.setup {
  settings = {
    haskell = {
      formattingProvider = "fourmolu",
    },
  },
}

-- Javascript/Typescript
lspconfig.tsserver.setup {}

-- Lua
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
    },
  },
}

-- Python
lspconfig.pyright.setup {
  before_init = function(params)
    params.processId = vim.NIL
  end,
}
vim.api.nvim_create_autocmd(
  "BufWritePost",
  {
    pattern = { "*.py", "*.pyi" },
    group = vim.api.nvim_create_augroup("AutoFormat", {}),
    callback = function()
      vim.cmd("silent !rye fmt %")
      vim.cmd("edit")
    end,
  }
)

-- TeX, Literate Haskell, Plain TeX, BibTeX
lspconfig.texlab.setup {
  filetypes = { 'tex', 'lhaskell', 'plaintex', 'bibtex' },
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
