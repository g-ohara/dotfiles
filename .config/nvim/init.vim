" ----------------------------------------------------------------------------
"  Character code
" ----------------------------------------------------------------------------

" Set character code before saving (on buffer)
set encoding=utf-8

" Set character code when saving
set fileencoding=utf-8

" Check the character code of the file automatically
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8

" Check the line feed code of the file automatically
set fileformats=unix,dos,mac


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
augroup local_indent
  autocmd!
  autocmd FileType vim,c,cpp setlocal tabstop=2 shiftwidth=2
augroup END


" ----------------------------------------------------------------------------
"  Design of editor
" ----------------------------------------------------------------------------

" Set line number
set number

" Display underline for cursor line
set cursorline

" Set column lign at 80 characters
set colorcolumn=80
highlight ColorColumn ctermbg=DarkGrey guibg=lightgrey

" Always show the status line
set laststatus=2

" Set color of vim terminal
set background=dark
colorscheme industry

" Enable syntax highlighting
syntax on


" ----------------------------------------------------------------------------
"  Other settings
" ----------------------------------------------------------------------------

" Always copy yanked text to clipboard
set clipboard=unnamedplus


" ----------------------------------------------------------------------------
"  Plugins
" ----------------------------------------------------------------------------

call plug#begin()
Plug 'dense-analysis/ale' " Manage linters and formatters
Plug 'itchyny/lightline.vim' " Display beautiful status line
Plug 'maximbaz/lightline-ale' " ALE support for lightline.vim
Plug 'github/copilot.vim' " Vim plugin for GitHub Copilot
call plug#end()


" ----------------------------------------------------------------------------
"  dense-analysis/ale
" ----------------------------------------------------------------------------

" Enable specific linters
let g:ale_linters = {
      \ 'python': ['flake8', 'pylint', 'mypy', 'ruff']
      \ }

" Show the linter, the error code and the severity with the error message
let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'

" Enable specific fixers
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'cpp': ['astyle'],
      \ 'python': ['autopep8', 'black', 'isort'],
      \ 'tex': ['latexindent'],
      \ }

" Options for fixers
let g:ale_python_flake8_options='--config ~/.config/flake8'
let g:ale_python_black_options='--line-length=79 --preview'

" Fix automatically when saving
let g:ale_fix_on_save = 1


" ----------------------------------------------------------------------------
"  itchyny/lightline.vim
"  maximbaz/lightline-ale
" ----------------------------------------------------------------------------

" Set lightline theme
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

" Settings for lightline-ale
let g:lightline.component_expand = {
      \ 'linter_checking': 'lightline#ale#checking',
      \ 'linter_infos': 'lightline#ale#infos',
      \ 'linter_warnings': 'lightline#ale#warnings',
      \ 'linter_errors': 'lightline#ale#errors',
      \ 'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \ 'linter_checking': 'right',
      \ 'linter_infos': 'right',
      \ 'linter_warnings': 'warning',
      \ 'linter_errors': 'error',
      \ 'linter_ok': 'right',
      \ }
let g:lightline.active = {
      \ 'right': [
        \ [
          \ 'linter_checking',
          \ 'linter_errors',
          \ 'linter_warnings',
          \ 'linter_infos',
          \ 'linter_ok'
        \ ],
        \ ['lineinfo'],
        \ [ 'percent' ],
        \ [ 'fileformat', 'fileencoding', 'filetype']
      \ ]
      \ }
