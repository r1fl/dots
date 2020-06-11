" TODO:
" italic comments
" traverse complete list
" cscope \ tags
"
" BOOKMARKS:
" :help cmdline
" :help text-objects
" map-modes
"
" snoremap
" cnoremap - commandline
" tnoremap

" exit select mode

" 
" Plugins
"

call plug#begin(stdpath('data') . '/plugged')

" appearence
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'sickill/vim-monokai'
"Plug 'liuchengxu/space-vim-dark'

" autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'zchee/deoplete-clang'
"Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" misc
Plug 'sheerun/vim-polyglot' " better syntax highlighting
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'jiangmiao/auto-pairs'

"Plug 'tpope/vim-surround'
Plug 'lepture/vim-jinja'
"Plug 'vim-syntastic/syntastic'
"Plug 'tpope/vim-fugitive'

call plug#end()

"
" Unfinished
"

"inoremap <silent><expr> <TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
set noshowmode
let g:jedi#show_call_signatures=2

let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
let g:deoplete#sources#clang#include_default_arguments = 1

let mapleader = "s"
let maplocalleader = "\\"

let g:deoplete#enable_at_startup = 1

"let g:UltiSnipsListSnippets='<nop>'
"let g:UltiSnipsExpandTrigger='<nop>'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

"
" Globals
"



" Onedark
let g:onedark_termcolors=16
let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 1

" Airline
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

"
" Settings
"

set clipboard+=unnamedplus

" Editor
set termguicolors
set number
set nowrap
set magic
set hlsearch incsearch
set foldlevelstart=0
set splitright nosplitbelow
set ignorecase
set magic
set nohidden
"set colorcolumn=72 " set only for python

" Tab

augroup tabsettings
	autocmd!

	autocmd FileType * setlocal noexpandtab
	autocmd FileType * setlocal smarttab
	autocmd FileType * setlocal tabstop=4
	autocmd FileType * setlocal shiftwidth=4
augroup END

"
" Mappings
"

map <C-P> :NERDTreeToggle<CR>

noremap <space> viw

" Move cursor line up / down
noremap <leader>j ddp
noremap <leader>k ddkP

" Upper case cursor word
inoremap <leader><c-u> <esc><space>Ui
nnoremap <leader><c-u> viwU

" Edit vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>:res -5<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Surround with quotes
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>l
vnoremap <leader>' <esc>`<i'<esc>`>a'<esc>l

" Finish search
nnoremap <leader>/ <esc>:noh<cr>

" Back to normal
inoremap jk <esc>
vnoremap nm <esc>
cnoremap jk <C-C><esc>
tnoremap jk <C-\><C-n>

" for select mode
inoremap <esc> <NOP>
"vnoremap <esc> <nop>
cnoremap <esc> <NOP>

" Resize tab
nnoremap <A-+> <esc>:res +1<cr>
nnoremap <A--> <esc>:res -1<cr>

" Help
nnoremap sos :aboveleft help 

" Search with \v
"nnoremap / /\v\c
"nnoremap ? ?\v\c

"
" Misc
"

syntax on
colorscheme onedark

