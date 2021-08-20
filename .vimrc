" General Config

set nocompatible
set number 
set backspace=indent,eol,start
syntax on
set fileencodings=ucs=bom,utf-8,utf-16,gbk,big5,gb18030,latin1
set t_Co=256
set showcmd
set autoread
set mouse=a
filetype indent on
set modeline
set textwidth=72
set formatoptions+=mB
set formatoptions-=tc
set secure

set nofoldenable

set hidden

set completeopt=menu,menuone

if $COLORTERM is 'truecolor'
    set termguicolors
endif

" Correct background rendering in some terminal
let &t_ut=''

" MacVim

if has("gui_running")
    if has("gui_macvim")
        set guifont=Monaco:h15
        set transparency=10
        set noimdisable

        noremap <D-1> :tabn 1<CR>
        noremap <D-2> :tabn 2<CR>
        noremap <D-3> :tabn 3<CR>
        noremap <D-4> :tabn 4<CR>
        noremap <D-5> :tabn 5<CR>
        noremap <D-6> :tabn 6<CR>
        noremap <D-7> :tabn 7<CR>
        noremap <D-8> :tabn 8<CR>
        noremap <D-9> :tabn 9<CR>
        noremap <D-0> :tablat<CR>
    endif
endif

" Identation

set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType css setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab

set wrap
"set nowrap
"set wrapmargin=4
set scrolloff=5
"set sidescrolloff=5
set laststatus=2
set ruler

set hlsearch
set incsearch
set ignorecase
set smartcase

" Completion

set wildmenu
set wildmode=longest:list,full
set wildignore=*.o,*.obj,*~
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif

" change default directory
let s:vim_swapfiles_dir = expand('~/.vim/.swp/')
if !isdirectory(s:vim_swapfiles_dir)
    silent! call mkdir(s:vim_swapfiles_dir, 'p')
endif
set directory=~/.vim/.swp//

" tags
set tags=./.tags;,.tags

" mapping
let mapleader=',' " change the key <leader>
nnoremap <leader>cd :cd %:p:h<CR> :pwd<CR>

source ~/.vim/plugin/init.vim
source ~/.vim/keybindings.vim

silent colorscheme onedark

highlight Pmenu ctermbg=grey
set exrc

if !empty(glob('~/.vim_local'))
    source ~/.vim_local
endif
