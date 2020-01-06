set nocompatible
set number
set encoding=utf-8
filetype off

"Enable folding
set foldmethod=indent
set foldlevel=99
" Enable fodling with space bar
nnoremap <space> za

" PEP 8 indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim')

Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-scripts/pythoncomplete.vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'fatih/vim-go'
Plugin 'google/vim-jsonnet'
" Plugin 'jnurmine/Zenburn'
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

call vundle#end()
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

"autocomplete window goes away
let g:ycm_autoclose_preview_window_after_completion=1
" shortcut goto
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

let python_highlight_all=1
syntax on

" colorscheme zenburn
let g:ycm_python_binary_path = 'python'

" yaml stuff
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
