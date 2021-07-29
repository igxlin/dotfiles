let g:ycm_server_log_level = 'info'
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings = 1

let g:ycm_filetype_whilelist = {
                        \ "c": 1, "cpp": 1, "sh": 1, "zsh": 1,
                        \ "python": 1, "go": 1, "gdscript": 1,
                        \ "lua": 1
                        \ }
let g:ycm_filetype_blacklist = {
            \ 'ledger': 1, 'markdown': 1, 'org': 1
            \ }
