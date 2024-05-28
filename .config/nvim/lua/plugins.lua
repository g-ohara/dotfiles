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

-- Run language servers in docker containers
-- https://github.com/neovim/nvim-lspconfig/wiki/Running-servers-in-containers
local root_pattern = lspconfig.util.root_pattern('.git')
local function project_name_to_container_name(server_name)
  local bufname = vim.api.nvim_buf_get_name(0)
  local filename = lspconfig.util.path.is_absolute(bufname) and bufname
      or lspconfig.util.path.join(vim.loop.cwd(), bufname)
  local project_dirname = root_pattern(filename) or lspconfig.util.path.dirname(filename)
  return vim.fn.fnamemodify(lspconfig.util.find_git_ancestor(project_dirname), ':t') .. "-" .. server_name
end

-- C/C++
lspconfig.clangd.setup {
  cmd = {
    'docker',
    'exec',
    '-i',
    project_name_to_container_name("clangd"),
    'clangd',
    '--background-index',
  },
}

-- Haskell
lspconfig.hls.setup {
  cmd = {
    'docker',
    'exec',
    '-i',
    project_name_to_container_name("hls"),
    'haskell-language-server',
    '--lsp',
  },
  root_dir = root_pattern
}

-- Javascript/Typescript
lspconfig.tsserver.setup {}

-- Lua
lspconfig.lua_ls.setup {
  cmd = {
    'docker',
    'exec',
    '-i',
    project_name_to_container_name("lua_ls"),
    'lua-language-server',
    '--background-index',
  },
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
  cmd = {
    'docker',
    'exec',
    '-i',
    project_name_to_container_name("pyright"),
    'rye',
    'run',
    'pyright-langserver',
    '--stdio',
  },
  before_init = function(params)
    params.processId = vim.NIL
  end,
}
vim.api.nvim_create_autocmd(
  "BufWritePost",
  {
    pattern = "*.py",
    group = vim.api.nvim_create_augroup("AutoFormat", {}),
    callback = function()
      vim.cmd(
        "silent !docker exec -i "
        .. project_name_to_container_name("pyright")
        .. " rye run black --quiet %"
      )
      vim.cmd(
        "silent !docker exec -i "
        .. project_name_to_container_name("pyright")
        .. " rye run isort --overwrite-in-place --quiet %"
      )
      vim.cmd("edit")
    end,
  }
)

-- TeX, Literate Haskell, Plain TeX, BibTeX
lspconfig.texlab.setup {
  cmd = {
    'docker',
    'exec',
    '-i',
    project_name_to_container_name("texlab"),
    'texlab',
  },
  filetypes = { 'tex', 'lhaskell', 'plaintex', 'bibtex' },
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
