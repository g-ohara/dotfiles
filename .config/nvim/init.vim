" ----------------------------------------------------------------------------
"  General settings
" ----------------------------------------------------------------------------

" checks file's character code automatically
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8


" ----------------------------------------------------------------------------
"  Indentation
" ----------------------------------------------------------------------------

" Set indentation to 4 spaces
set tabstop=4 shiftwidth=4

" Insert indents automatically when starting a new line
set smartindent

" Only use spaces for indentation (no tabs)
set expandtab

" Set indentation to 2 spaces for C and C++
autocmd FileType c,cpp setlocal tabstop=2 shiftwidth=2


" ----------------------------------------------------------------------------
"  Design of editor
" ----------------------------------------------------------------------------

" set number when width of terminal is enough
if &co > 80
  set number
endif
set cursorline

" set column lign at 80
set colorcolumn=80
highlight ColorColumn ctermbg=DarkGrey guibg=lightgrey

" Always show the status line
set laststatus=2

" set color of vim terminal
set background=dark
colorscheme industry


" ----------------------------------------------------------------------------
"  Plugins
" ----------------------------------------------------------------------------

call plug#begin()
Plug 'dense-analysis/ale' " Manage linters and formatters
Plug 'github/copilot.vim' " Vim plugin for GitHub Copilot
Plug 'itchyny/lightline.vim' " Display beautiful status line
Plug 'lervag/vimtex' "A modern Vim and neovim filetype plugin for LaTeX files.
call plug#end()


" ----------------------------------------------------------------------------
"  dense-analysis/ale
" ----------------------------------------------------------------------------

let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'cpp': ['astyle'],
  \   'python': ['autopep8', 'black', 'isort'],
  \ }
let g:ale_fix_on_save = 1
let g:ale_python_black_options='--line-length=79 --preview'
let g:ale_python_flake8_options='--config ~/.config/flake8'


" ----------------------------------------------------------------------------
"  lervag/vimtex
" ----------------------------------------------------------------------------

" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
" let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
" let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
" let g:vimtex_compiler_method = 'latexrun'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ","
