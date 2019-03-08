colorscheme elflord
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" autocomplete
Plugin 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim' 

"Plugin 'anned20/vimsence' " discord
Plugin 'chrisbra/Colorizer'
Plugin 'scrooloose/nerdtree'
Plugin 'w0rp/ale'

call vundle#end()            " required
filetype plugin indent on    " required

runtime defaults.vim

"set runtimepath^=~/.vim/vimsence
set number
set tabstop=4
set shiftwidth=4

autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4

autocmd FileType asm set syntax=nasm

map <C-P> :NERDTreeToggle<CR>

