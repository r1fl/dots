colorscheme ron

call plug#begin('~/.local/share/nvim/plugged')

" autocomplete for languages
Plug 'davidhalter/jedi-vim' 

" Linter
"Plug 'w0rp/ale'

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
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-vim-lsp'

" Independent autocomple
Plug 'Valloric/YouCompleteMe'
Plug 'davidhalter/jedi-vim'
Plug 'Vimjas/vim-python-pep8-indent'

call plug#end()

set number
map <C-P> :NERDTreeToggle<CR>

" Use system clipboard
set clipboard+=unnamedplus

" Leader
let mapleader = "-"
let maplocalleader = "\\"

" Tab width
set noexpandtab shiftwidth=4 tabstop=4

" Select cursor word
noremap <space> viw

" Move cursor line up / down
noremap <leader>- ddp
noremap <leader>_ ddkP

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
inoremap <esc> <nop>
vnoremap <esc> <nop>

" Resize tab
nnoremap <A-+> <esc>:res +1<cr>
nnoremap <A--> <esc>:res -1<cr>

" Some insert abbrevations
iabbrev @@ itamarne@checkpoint.com

" Insert comments
augroup comments
	autocmd FileType python nnoremap <buffer> <localleader>c v<esc>I# <esc>`<2l
	"autocmd FileType python vnoremap <buffer> <localleader>c I# j<localleader>
augroup END

" Set list

augroup filetype_html
	autocmd!
	autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END

" Select next parentheses
onoremap in( :<c-u>normal! f(vi(<cr>

