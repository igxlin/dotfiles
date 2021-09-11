if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let s:settings = split(expand('~/.vim/plugin/*.vim'))

function! s:load_settings()
    for setting in s:settings
        if setting !~ 'init.vim'
            exec "source " . setting
        endif
    endfor
endfunction

call plug#begin('~/.vim/plugged')

" General
Plug 'Valloric/YouCompleteMe', {
            \ 'do': 'python3 ./install.py --clangd-completer',
            \ }
Plug 'prabirshrestha/vim-lsp'

Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'
Plug 'godlygeek/tabular'
Plug 'ludovicchabant/vim-gutentags'

let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args = ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args = ['--c-kinds=+px']


let g:ycm_language_server = []
let g:Lf_RootMarkers = []
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline#extensions#tabline#enabled = 1
Plug 'tpope/vim-fugitive'

nnoremap <silent> <leader>gl :Gclog! -- %<CR>
nnoremap <silent> <leader>gd :Gdiffsplit <CR>
nnoremap <silent> <leader>gs :G<CR>

Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'

map <Space> <Plug>(easymotion-prefix)

" Language specific
Plug 'habamax/vim-godot', {'for': 'gdscript'}
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'ledger/vim-ledger', {'for': 'ledger'}

let g:ledger_bin = 'ledger'
let g:ledger_align_at = 50
let g:ledger_commodity_before = 0

au FileType ledger call s:ledger_keymap()

function! s:ledger_keymap() abort
    noremap { ?^\d<CR>
    noremap } /^\d<CR>
    inoremap <silent> <Tab> <C-r>=ledger#autocomplete_and_align()<CR>
    vnoremap <silent> <Tab> :LedgerAlign<CR>
endfunction
Plug 'iamcco/markdown-preview.nvim', {
            \ 'do': {-> mkdp#util#install()},
            \ 'for': ['markdown', 'vim-plug']
            \ }

" REPL
Plug 'jpalardy/vim-slime', {
            \'on': [
                \'<Plug>SlimeRegionSend', 
                \'<Plug>SlimeParagraphSend',
                \'<Plug>SlimeConfig'
                \]
            \}

let g:slime_no_mappings = 1

xmap <c-c><c-c> <Plug>SlimeRegionSend
nmap <c-c><c-c> <Plug>SlimeParagraphSend
nmap <c-c>v     <Plug>SlimeConfig

let g:slime_target = 'tmux'

" Misc
Plug 'skywind3000/asyncrun.vim'

let g:asyncrun_open = 6 " the number of lines of quickfix window
let g:asyncrun_bell = 1 " the bell rings when the task is done
" use f10 to open/close asyncrun quickfix window
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>


Plug 'mhinz/vim-signify'
Plug 'tpope/vim-unimpaired'

Plug 'joshdick/onedark.vim'
Plug 'liuchengxu/vista.vim'

let g:vista_default_executive = 'ctags'

let g:vista_executive_for = {
            \ 'go': 'vim_lsp',
            \ }

nnoremap <leader>s :Vista<CR>

Plug 'puremourning/vimspector', { 'on': '<Plug>VimspectorContinue' }

let g:vimspector_install_gadgets = ['debugpy']

nmap <silent> <Leader>dc <Plug>VimspectorContinue
nmap <silent> <Leader>dq <Plug>VimspectorStop
nmap <silent> <Leader>db <Plug>VimspectorToggleBreakpoint
nmap <silent> <Leader>dn <Plug>VimspectorStepOver
nmap <silent> <Leader>ds <Plug>VimspectorStepInto
nmap <silent> <Leader>df <Plug>VimspectorStepOut
nmap <silent> <Leader>di <Plug>VimspectorBalloonEval
xmap <silent> <Leader>di <Plug>VimspectorBalloonEval

let s:mapped = {}

function! s:set_debug_keymaps() abort
    if has_key(s:mapped, string(bufnr()))
        return
    endif

    " nmap <silent> <buffer> c <Plug>VimspectorContinue
    " nmap <silent> <buffer> q <Plug>VimspectorStop
    " nmap <silent> <buffer> b <Plug>VimspectorToggleBreakpoint
    nmap <silent> <buffer> m <Plug>VimspectorStepOver
    " nmap <silent> <buffer> s <Plug>VimspectorStepInto
    " nmap <silent> <buffer> f <Plug>VimspectorStepOut
    " nmap <silent> <buffer> i <Plug>VimspectorBalloonEval
    " xmap <silent> <buffer> i <Plug>VimspectorBalloonEval

    let s:mapped[string(bufnr())] = {'modifiable': &modifiable}

    setlocal nomodifiable
endfunction

function! s:unset_debug_keymaps() abort
    let original_buf = bufnr()
    let hidden = &hidden

    try
        set hidden
        for bufnr in keys(s:mapped)
            try
                execute 'noautocmd buffer' bufnr
                " silent! nunmap <buffer> c
                " silent! nunmap <buffer> q
                " silent! nunmap <buffer> b
                silent! nunmap <buffer> m
                " silent! nunmap <buffer> s
                " silent! nunmap <buffer> f
                " silent! nunmap <buffer> i
                " silent! xunmap <buffer> i
                
                let &l:modifiable = s:mapped[bufnr]['modifiable']
            endtry
        endfor
    finally
        execute 'noautocmd buffer' original_buf
        let &hidden = hidden
    endtry

    let s:mapped = {}
endfunction

augroup CustomMappings
    au!
    autocmd User VimspectorJumpedToFrame call s:set_debug_keymaps()
    autocmd User VimspectorDebugEnded call s:unset_debug_keymaps()
augroup end
call plug#end()

call s:load_settings()
