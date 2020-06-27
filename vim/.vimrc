syntax enable
filetype on
syntax on

set nocompatible              " be iMproved, required
set t_Co=256
set tabstop=4
set history=1000
set showmatch
set showcmd
set autoindent
set smartindent
set foldmethod=marker

set mouse=a
set laststatus=2
set nu
set cursorline    "or set cul 设置光标所在的行
set colorcolumn=81
" set textwidth=80

set incsearch
au BufWinEnter * nohlsearch
autocmd cursorhold * set nohlsearch

let mapleader = "\<Space>"

noremap / :set hlsearch<cr>/
noremap ? :set hlsearch<cr>?
noremap * *:set hlsearch<cr>

nnoremap <leader>w :w<CR>
nnoremap <leader>n :nohls<CR>
nnoremap <leader>p "+p
nnoremap <leader>y "+y

" colorscheme {{{

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif
colorscheme onedark

" }}}

" AutoCompletion {{{

inoremap [  []<Esc>i
inoremap (  ()<Esc>i
inoremap {  {}<Esc>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>

autocmd Syntax html,vim inoremap < <lt>><Esc>i | inoremap > <c-r>=ClosePair('>')<CR>

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

function CloseBracket()
    if match(getline('.' + 1), '\s*}') < 0
        return "\<CR>}"
    else
        return "\<Esc>j0f}a"
    endif
endf

function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col-2] == "\\"
        "Inserting a quoted quotation mark into string
         return a:char
     elseif line[col-1] == a:char
         "Escaping out of the string
        return "\<Right>"
    else
        "Starting a String
         return a:char.a:char."\<Esc>i"
     endif
 endf

" }}}

" Plug {{{
call plug#begin()

Plug 'Yggdroot/indentLine'
Plug 'Valloric/YouCompleteMe'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'

call plug#end()            " required
filetype plugin indent on    " required

" }}}

" YouCompleteMe {{{

let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
let g:ycm_path_to_python_interpreter='/usr/bin/python'
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_cache_omnifunc=0
let g:ycm_complete_in_strings = 1
let g:ycm_seed_identifiers_with_syntax=1 "补全关键字 
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"inoremap <expr> <CR>       pumvisible() ? '<C-y>' : '\<CR>'     

" }}}

" indentLine and lightline {{{

let g:indentLine_char = '┆'
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2

let g:lightline ={
	\ 'colorschme': 'onedark',
	\}

" }}}
