"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath
"source ~/.vimrc
runtime defaults.vim
colorscheme ron

call plug#begin('~/.local/share/nvim/plugged')

" autocomplete for languages
"Plug 'artur-shaik/vim-javacomplete2'
Plug 'davidhalter/jedi-vim' 

" Linter
"Plug 'w0rp/ale'

" autocomplete
Plug 'Valloric/YouCompleteMe'
Plug 'maralla/completor.vim'

" discord appearence
"Plug 'anned20/vimsence' 

" Nice status bar
Plug 'vim-airline/vim-airline'

" Color visualizer
Plug 'chrisbra/Colorizer'

" File sidebar
Plug 'scrooloose/nerdtree'

" Auto close parens, braces, brackets, etc
Plug 'jiangmiao/auto-pairs'

" Language Server Protocol and autocomplete
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

set number 
set noexpandtab
set tabstop=4
set shiftwidth=4

autocmd FileType python set sw=4
autocmd FileType python set ts=4

autocmd FileType asm set syntax=nasm
"autocmd FileType asm ALEDisable

map <C-P> :NERDTreeToggle<CR>


"autocmd FileType java setlocal omnifunc=javacomplete#Complete

" LSP LanguageClient
let g:LanguageClient_serverCommands = {
    \ 'java': ['/usr/local/bin/jdtls', '-data', getcwd()],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


