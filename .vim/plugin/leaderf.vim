let g:Lf_ShowDevIcons = 1
let g:Lf_UseCache = 0

let g:Lf_CommandMap = {
            \ '<C-J>': ['<C-N>'],
            \ '<C-K>': ['<C-P>'],
            \ }

let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_ShortcutF = "<leader>ff"

noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>fr :<C-U><C-R>=printf("Leaderf rg %s", "")<CR><CR>
noremap <leader>fs :<C-U><C-R>=printf("Leaderf self %s", "")<CR><CR>
noremap <leader>fc :<C-U><C-R>=printf("Leaderf command %s", "")<CR><CR>
noremap <leader>f<space> :Leaderf<space>
noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

let g:Lf_WorkingDirectoryMode = 'AF'

let g:Lf_RootMarkers += ['.project', '.root', '.svn', '.git', '.hg', '.projectile']
