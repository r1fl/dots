" TODO:
" - Replace with clipboard

" Vim-Plug {{{
" 
call plug#begin('~/.local/share/nvim/plugged')

" Color schemes
Plug 'sickill/vim-monokai'
Plug 'liuchengxu/space-vim-dark'

" Discord appearence
"Plug 'anned20/vimsence' 

" Nice status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color visualizer
Plug 'chrisbra/Colorizer'

" File sidebar
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Auto close parens, braces, brackets, etc
Plug 'jiangmiao/auto-pairs'

" Language Server Protocol and autocomplete
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'autozimu/LanguageClient-neovim'
Plug 'Shougo/deoplete.nvim'
Plug 'junegunn/fzf'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'

" Independent autocomplete
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

call plug#end()

" }}}

" Basic settings {{{
" 

set shortmess=I

"colorscheme ron
colorscheme monokai

set number
set nowrap
set magic
set hlsearch incsearch
set foldlevelstart=0
set splitright nosplitbelow
set ignorecase
set nohidden

" Use system clipboard
set clipboard+=unnamedplus

" Leader
let mapleader = "s"
let maplocalleader = "\\"

" Tab stuff
set noexpandtab
set shiftwidth=4
set tabstop=4

" Airline status bar
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
"let g:airline_theme='base16_spacemacs'
let g:airline_theme='angr'

" Autocompletion
let g:LanguageClient_serverCommands = {}
let g:jedi#completions_enabled = 0

let g:deoplete#enable_at_startup = 1
let g:LanguageClient_autoStart = 1

" }}}

" Mappings {{{
" 

" Nerd Tree
map <C-P> :NERDTreeToggle<CR>

" Select cursor word
noremap <space> viw

" Move cursor line up / down
noremap <leader>j ddp
noremap <leader>k ddkP

" Upper case cursor word
inoremap <leader><c-u> <esc><space>Ui
nnoremap <leader><c-u> viwU

" Edit vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>:res -5<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>

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

inoremap <esc> <nop>
vnoremap <esc> <nop>
cnoremap <esc> <nop>

" Resize tab
nnoremap <A-+> <esc>:res +1<cr>
nnoremap <A--> <esc>:res -1<cr>

" Help
nnoremap sos :aboveleft help 

" Search with \v
nnoremap / /\v\c
nnoremap ? ?\v\c

" Autocompletion ???
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Snippets ???
imap <C-space>   <Plug>(neosnippet_expand_or_jump)
smap <C-space>   <Plug>(neosnippet_expand_or_jump)
xmap <C-space>   <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Append semicolon
augroup semicolon
	autocmd!
	autocmd FileType c,cpp,java nnoremap <buffer><leader>; :call Semicolon()<cr>
augroup end

" }}}

" Abbreviations {{{
"
" Some insert abbrevations
iabbrev @@ itamarne@checkpoint.com

" }}}

" Operations {{{
"

" Select next parentheses
onoremap in( :<c-u>normal! f(vi(<cr>

" }}}

" File settings {{{
" 

" Vimscript file settings {{{
"

augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup end

" }}}

" Python file settings {{{
"

augroup filetype_python
	autocmd!
	" Insert comments
	autocmd FileType python nnoremap <buffer> <localleader>c v<esc>I# <esc>`<2l
	"autocmd FileType python vnoremap <buffer> <localleader>c I# j<localleader>
	
	autocmd FileType python set noexpandtab
	autocmd FileType python set tabstop=4
	autocmd FileType python set shiftwidth=4

augroup end

" }}}

" Html file settings {{{
augroup filetype_html
	autocmd!
	
	" Format file
	autocmd FileType html nnoremap <buffer><localleader>f Vatzf
augroup end
" }}}

" C\CPP file settings {{{
" 

if executable('clangd')
	let g:LanguageClient_serverCommands.c = ['clangd']
	let g:LanguageClient_serverCommands.cpp = ['clangd']
endif

" }}}

" Java file settings {{{
"

"if executable()
" }}}

" Markdown file settings {{{
augroup filetype_md
	autocmd!

	" Edit in header ???
	autocmd FileType markdown onoremap <buffer> ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
augroup end
" }}}

" }}}

" Functions {{{
" 

function! Semicolon()
	" Append semicolon if does not exist
	
	normal! mq$
	let char = getline('.')[col('.')-1]

	if char !=# ';'
		normal! a;
	endif
	normal! `q
endfunction

" }}}

