" Vim 8 native packages: plugins live in ~/.vim/pack/plugins/start/

" {{{ ale
if !filereadable($HOME . "/.vim/pack/plugins/start/ale/plugin/ale.vim")
    echom expand("%:p:t") . ": ale unavailable"
else
    highlight SignColumn ctermbg=None
    let g:ale_sign_error = 'E▸'
    let g:ale_sign_warning = 'W▸'
    let g:ale_sign_style_error = 'e▸'
    let g:ale_sign_style_warning = 'w▸'
    let g:ale_open_list = 1
    let g:ale_lint_on_enter = 0
    let g:ale_disable_lsp = 1
endif
" }}}

" {{{ coc.nvim
if !filereadable($HOME . "/.vim/pack/plugins/start/coc.nvim/plugin/coc.vim")
    echom expand("%:p:t") . ": coc.nvim unavailable"
else
    let g:coc_global_extensions = [
        \ 'coc-pyright',
        \ 'coc-rust-analyzer',
        \ 'coc-clangd',
        \ ]

    " Use tab for trigger completion
    inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ "\<TAB>"
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    " Confirm completion with Enter
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
        \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " GoTo navigation
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Show documentation in preview window
    nnoremap <silent> K :call ShowDocumentation()<CR>
    function! ShowDocumentation()
        if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
        else
            call feedkeys('K', 'in')
        endif
    endfunction

    " Symbol renaming
    nmap <leader>rn <Plug>(coc-rename)

    " Diagnostics navigation
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)
endif
" }}}

" vim:fdm=marker
