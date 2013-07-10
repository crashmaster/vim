" {{{ pathogen
if !filereadable($HOME . "/.vim/autoload/pathogen.vim")
    echom expand("%:p:t") . ": pathogen unavailable"
else
    execute pathogen#infect()
endif
" }}}

" {{{ YouCompleteMe
if !filereadable($HOME . "/.vim/bundle/YouCompleteMe/plugin/youcompleteme.vim")
    echom expand("%:p:t") . ": youcompleteme unavailable"
else
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_add_preview_to_completeopt = 0
    let g:ycm_complete_in_comments = 0
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_filetype_whitelist = { 'cpp': 1, 'python': 1 }
    let g:ycm_global_ycm_extra_conf = $HOME . "/tmp/ycm_conf.py"

    nnoremap <leader>q :YcmCompleter GoToDefinitionElseDeclaration<CR>
    nnoremap <leader>w :YcmCompleter GoToDeclaration<CR>
    nnoremap <leader>e :YcmCompleter GoToDefinition<CR>
endif
" }}}

" {{{ syntastic
if !filereadable($HOME."/.vim/bundle/syntastic/plugin/syntastic.vim")
    echom expand("%:p:t") . ": syntastic unavailable"
else
    highlight SignColumn term=standout ctermfg=14 ctermbg=0
    let g:syntastic_error_symbol = 'E▸'
    let g:syntastic_warning_symbol = 'W▸'
    let g:syntastic_style_error_symbol = 'e▸'
    let g:syntastic_style_warning_symbol = 'w▸'
    let g:syntastic_sh_checkers = ['sh', 'checkbashisms']
    let g:syntastic_check_on_open = 1
    let g:syntastic_enable_signs = 1
    let g:syntastic_enable_balloons = 0
    let g:syntastic_enable_highlighting = 1
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
endif
" }}}

" vim:fdm=marker
