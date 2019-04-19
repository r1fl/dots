" Vim-Plug {{{
" 
call plug#begin('~/.local/share/nvim/plugged')

" autocomplete for languages

" Discord appearence
"Plug 'anned20/vimsence' 

" Nice status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color visualizer
Plug 'chrisbra/Colorizer'

" File sidebar
Plug 'scrooloose/nerdtree'

" Auto close parens, braces, brackets, etc
"Plug 'jiangmiao/auto-pairs'

" Language Server Protocol and autocomplete
Plug 'autozimu/LanguageClient-neovim'
Plug 'Shougo/deoplete.nvim'
Plug 'junegunn/fzf'

" Independent autocomplete
Plug 'davidhalter/jedi-vim' 
Plug 'deoplete-plugins/deoplete-jedi'
"Plug 'Valloric/YouCompleteMe'
"Plug 'Vimjas/vim-python-pep8-indent'

call plug#end()

" }}}

" Basic settings {{{
" 

colorscheme ron

set number
set nowrap

set foldlevelstart=0

" Use system clipboard
set clipboard+=unnamedplus

" Leader
let mapleader = "s"
let maplocalleader = "\\"

" Tab stuff
set noexpandtab shiftwidth=4 tabstop=4

" Airline status bar
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='sol'

" }}}

" Autocompletion {{{
"

let g:jedi#completions_enabled = 0

let g:deoplete#enable_at_startup = 1
let g:LanguageClient_autoStart = 1

let g:LanguageClient_serverCommands = {
			\ 'c': ['clangd'],
			\ 'cpp': ['clangd'],
			\ }

"set omnifunc=LanguageClient#complete
"set completefunc=LanguageClient#complete
"call deoplete#custom#source('LanguageClient', 'min_pattern_length', 2)


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

inoremap <esc> <nop>
vnoremap <esc> <nop>
cnoremap <esc> <nop>

" Resize tab
nnoremap <A-+> <esc>:res +1<cr>
nnoremap <A--> <esc>:res -1<cr>

" Help
nnoremap sos :help 

" }}}

" Abbreviations {{{
"
" Some insert abbrevations
iabbrev @@ itamarne@checkpoint.com

" }}}

" Operations {{{

" Select next parentheses
onoremap in( :<c-u>normal! f(vi(<cr>

" }}}

" File specific settings {{{
" 

" Vimscript file settings {{{
"

augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup end

" }}}

" Python file settings {{{
augroup filetype_python
	autocmd!
	" Insert comments
	autocmd FileType python nnoremap <buffer> <localleader>c v<esc>I# <esc>`<2l
	"autocmd FileType python vnoremap <buffer> <localleader>c I# j<localleader>
	
augroup end
" }}}

" Html file settings {{{
augroup filetype_html
	autocmd!
	
	" Format file
	autocmd FileType html nnoremap <buffer><localleader>f Vatzf
augroup end
" }}}

" C file settings {{{
augroup filetype_c
	autocmd!

	" Insert semicolon and restore cursor position
	"autocmd FileType c nnoremap <buffer><localleader>; :execute "normal! mqA;\e`q"<cr>
	autocmd FileType c nnoremap <buffer><localleader>; :call Semicolon()<cr>

augroup end
" }}}

" }}}

" Functions {{{
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
