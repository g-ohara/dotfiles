------------------------------------------------------------------------------
-- Character code
------------------------------------------------------------------------------

-- Set character code before saving (on buffer)
vim.opt.encoding = 'utf-8'

-- Set character code when saving
vim.opt.fileencoding = 'utf-8'

-- Check the character code of the file automatically
vim.opt.fileencodings = 'iso-2022-jp,euc-jp,sjis,utf-8'

-- Check the line feed code of the file automatically
vim.opt.fileformats = 'unix,dos,mac'


------------------------------------------------------------------------------
-- Formatting
------------------------------------------------------------------------------

-- Set indentation to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Insert indents automatically when starting a new line
vim.opt.smartindent = true

-- Only use spaces for indentation (no tabs)
vim.opt.expandtab = true

-- Set indentation to 2 spaces for C and C++
vim.api.nvim_create_augroup('local_indent', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'local_indent',
  pattern = { 'c', 'cpp', 'lua', 'vim' },
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
  end
})

-- Format automatically on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('lsp_format', { clear = true }),
  callback = function()
    vim.lsp.buf.format()
  end
})


------------------------------------------------------------------------------
-- Design of the editor
------------------------------------------------------------------------------

-- Set line number
vim.opt.number = true

-- Display underline for cursor line
vim.opt.cursorline = true

-- Set column lign at 80 characters
vim.opt.colorcolumn = '80'
vim.cmd("highlight ColorColumn ctermbg=DarkGrey guibg=lightgrey")

-- Always show the status line
vim.opt.laststatus = 2

-- Set color of vim terminal
-- My favorite themes are 'desert', 'evening', 'habamax' and 'slate'
vim.cmd [[colorscheme desert]]

-- Enable syntax highlighting
vim.opt.syntax = 'on'


------------------------------------------------------------------------------
-- Plugins
------------------------------------------------------------------------------

-- Install lazy.nvim (https://github.com/folke/lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins")


------------------------------------------------------------------------------
-- itchyny/lightline.vim
------------------------------------------------------------------------------

-- Set lightline theme
vim.cmd("let g:lightline = {'colorscheme': 'solarized'}")


------------------------------------------------------------------------------
-- neovim/nvim-lspconfig
------------------------------------------------------------------------------

local lspconfig = require("lspconfig")

-- Run language servers in docker containers
-- https://github.com/neovim/nvim-lspconfig/wiki/Running-servers-in-containers
local root_pattern = lspconfig.util.root_pattern('.git')
local function project_name_to_container_name()
  local bufname = vim.api.nvim_buf_get_name(0)
  local filename = lspconfig.util.path.is_absolute(bufname) and bufname
      or lspconfig.util.path.join(vim.loop.cwd(), bufname)
  local project_dirname = root_pattern(filename) or lspconfig.util.path.dirname(filename)
  return vim.fn.fnamemodify(lspconfig.util.find_git_ancestor(project_dirname), ':t')
end

-- C/C++
lspconfig.clangd.setup {
  cmd = {
    'docker',
    'exec',
    '-i',
    project_name_to_container_name(),
    'clangd',
    '--background-index',
  },
}

-- Lua
lspconfig.lua_ls.setup {
  cmd = {
    'docker',
    'exec',
    '-i',
    project_name_to_container_name(),
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
    project_name_to_container_name(),
    'pyright-langserver',
    '--stdio',
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
  before_init = function(params)
    params.processId = vim.NIL
  end,
}
